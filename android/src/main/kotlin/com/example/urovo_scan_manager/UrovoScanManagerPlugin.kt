package com.example.urovo_scan_manager

import android.device.ScanManager
import android.util.Log
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** UrovoScanManagerPlugin */
class UrovoScanManagerPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    /// Библиотека для взаимодействия со сканером Urovo
    private lateinit var scanManager: ScanManager

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "urovo_scan_manager")
        channel.setMethodCallHandler(this)
        scanManager = ScanManager()
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "openScanner" -> {
                /// Turn on the power for the barcode reader.
                val isOpened = scanManager.openScanner()
                if (!isOpened) {
                    result.error(
                        "SCANNER_ERROR",
                        "Can't turn on the power for the barcode reader",
                        "Can't turn on the power for the barcode reader",
                    )
                }
            }
            "closeScanner" -> {
                /// Turn off the power for the barcode reader.
                val isOpened = scanManager.closeScanner()
                if (!isOpened) {
                    result.error(
                        "SCANNER_ERROR",
                        "Can't turn off the power for the barcode reader",
                        "Can't turn off the power for the barcode reader",
                    )
                }
            }
            "switchOutputMode" -> {
                /// Set the output mode of the barcode reader (either send output to text box or as Android intent).
                ///
                /// TextBox Mode allows the captured data to be sent to the text box in focus.
                /// Intent mode allows the captured data to be sent as an implicit Intent.
                /// Application interested in the scan data should register an action
                /// as ACTION_DECODE broadcast listerner. In the onReceive method, get the information.
                /// The information are barcode data, bardcode string, length of barcode data,
                /// and barcode type (symbology).
                ///
                /// Parameters
                /// mode - 0 if barcode output is to be sent as intent,
                /// 1 if barcode output is to be sent to the text box in focus. The default output mode is TextBox Mode.
                val isSuccess = scanManager.switchOutputMode(call.arguments as Int)
                if (!isSuccess) {
                    result.error(
                        "SCANNER_ERROR",
                        "Can't set the output mode of the barcode reader",
                        "Can't set the output mode of the barcode reader",
                    )
                }
            }
            "getOutputMode" -> {
                /// Get the current scan result output mode.
                ///
                /// Parameters:
                /// 0 if the barcode is sent as intent,
                /// 1 if barcode is sent to the text box in focus. Default 1.
                val outputMode = scanManager.outputMode
                Log.d("DEBUG_LOG", outputMode.toString())
                result.success(outputMode)
            }
            "getScannerState" -> {
                /// Get the scanner power states.
                ///
                /// True if the scanner power on, false if power off.
                val scannerState = scanManager.scannerState
                Log.d("DEBUG_LOG", "scannerState: $scannerState")
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
}
