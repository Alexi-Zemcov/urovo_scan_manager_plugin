package com.example.urovo_scan_manager

import android.content.*
import android.device.ScanManager
import android.device.scanner.configuration.PropertyID
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


/** UrovoScanManagerPlugin */
class UrovoScanManagerPlugin : FlutterPlugin, MethodCallHandler {

    /** The MethodChannel that will the communication between Flutter and native Android

    This local reference serves to register the plugin with the Flutter Engine and unregister it
    when the Flutter Engine is detached from the Activity */
    private lateinit var channel: MethodChannel

    /** Библиотека для взаимодействия со сканером Urovo */
    private lateinit var scanManager: ScanManager

    /**
     *  Инициализируется в методе [onAttachedToEngine], необходим для регистрации [onScanReceiver]
     *  методом [registerScanReceiver]
     */
    private lateinit var applicationContext: Context

    /** Обработчик получения баркода через интент */
    private val onScanReceiver: BroadcastReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context, intent: Intent) {

            /**
             *  Get scan results, including string and byte data etc.
             *  */
            val barcodeString =
                intent.getStringExtra(ScanManager.BARCODE_STRING_TAG)
            val barcodeLength =
                intent.getIntExtra(ScanManager.BARCODE_LENGTH_TAG, 0)

            /**
             * Описание типов https://www.urovo.com/developer/android/device/scanner/configuration/Constants.Symbology.html
             * */
            val barcodeType = intent.getByteExtra(
                ScanManager.BARCODE_TYPE_TAG,
                0.toByte()
            )

            val map: MutableMap<String, Any?> = HashMap()
            map["code"] = barcodeString
            map["type"] = barcodeType
            map["length"] = barcodeLength
            channel.invokeMethod("barcodeScanned", map)
        }
    }

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "urovo_scan_manager")
        channel.setMethodCallHandler(this)
        scanManager = ScanManager()
        applicationContext = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "openScanner" -> {
                /// Turn on the power for the barcode reader.
                val isOpened = scanManager.openScanner()
                result.success(isOpened)
            }
            "closeScanner" -> {
                /// Turn off the power for the barcode reader.
                val isClosed = scanManager.closeScanner()
                result.success(isClosed)
            }
            "startListening" -> {
                registerScanReceiver(true)
                result.success(null)
            }
            "stopListening" -> {
                registerScanReceiver(false)
                result.success(null)
            }
            "switchOutputMode" -> {
                /** Set the output mode of the barcode reader (either send output to text box or as Android intent).
                 *
                 * TextBox Mode allows the captured data to be sent to the text box in focus.
                 * Intent mode allows the captured data to be sent as an implicit Intent.
                 * Application interested in the scan data should register an action
                 * as ACTION_DECODE broadcast listener. In the onReceive method, get the information.
                 * The information are barcode data, barcode string, length of barcode data,
                 * and barcode type (symbology).
                 *
                 * Parameters
                 * mode - 0 if barcode output is to be sent as intent,
                 * 1 if barcode output is to be sent to the text box in focus. The default output mode is TextBox Mode. */
                val isSuccess = scanManager.switchOutputMode(call.arguments as Int)
                result.success(isSuccess)
            }

            "switchBeepSound" -> {
                val index = intArrayOf(PropertyID.SEND_GOOD_READ_BEEP_ENABLE)
                val value = intArrayOf(call.arguments as Int)
                val res = scanManager.setParameterInts(index, value)
                result.success(res)
            }

            "getBeepSoundState" -> {
                /** Get the current beep sound state. */
                val index = intArrayOf(PropertyID.SEND_GOOD_READ_BEEP_ENABLE)
                val results: IntArray = scanManager.getParameterInts(index)
                result.success(results.first())
            }

            "getOutputMode" -> {
                /** Get the current scan result output mode.
                 *
                 * Parameters:
                 * 0 if the barcode is sent as intent,
                 * 1 if barcode is sent to the text box in focus. Default 1.
                 *
                 * P.S. Однажды этот метод присылал 16843134, после переключения режим через настройки
                 * стал присылать 0 и 1 */
                val outputMode = scanManager.outputMode
                result.success(outputMode)
            }
            "getScannerState" -> {
                /** Get the scanner power states.
                 *
                 * True if the scanner power on, false if power off. */
                val scannerState = scanManager.scannerState
                result.success(scannerState)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }


    /**
     * @param register , ture register , false unregister
     */
    private fun registerScanReceiver(register: Boolean) {
        if (register) {
            val filter = IntentFilter()
            val idbuf = intArrayOf(
                PropertyID.WEDGE_INTENT_ACTION_NAME,
                PropertyID.WEDGE_INTENT_DATA_STRING_TAG
            )
            val valueBuf = scanManager.getParameterString(idbuf)
            if (valueBuf != null && valueBuf[0] != null && valueBuf[0] != "") {
                filter.addAction(valueBuf[0])
            } else {
                filter.addAction(
                    ScanManager.ACTION_DECODE
                )
            }
            ContextWrapper(applicationContext).registerReceiver(onScanReceiver, filter)
        } else {
            scanManager.stopDecode()
            ContextWrapper(applicationContext).unregisterReceiver(onScanReceiver)
        }
    }
}
