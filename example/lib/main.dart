import 'package:flutter/material.dart';
import 'package:urovo_scan_manager/dto/barcode_dto.dart';
import 'package:urovo_scan_manager/enums/output_mode.dart';
import 'package:urovo_scan_manager/urovo_scan_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _scanManager = UrovoScanManager();
  OutputMode? _outputMode;
  bool? _scannerState;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          crossAxisAlignment: (CrossAxisAlignment.stretch),
          children: [
            const Spacer(),
            StreamBuilder<BarcodeDTO?>(
              stream: _scanManager.barcode,
              builder: (context, barcodeValue) {
                final barcode = barcodeValue.data;
                return barcode == null
                    ? const Center(
                        child: Text('Scan smething'),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Barcode: ${barcode.code}",
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "Barcode Type: ${barcode.typeEnum.name}",
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "Barcode Type: ${barcode.type}",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
              },
            ),
            const Spacer(),
            ListTile(
              title: const Text('Output mode:'),
              trailing: Text('${_outputMode?.name}'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: (_outputMode != OutputMode.intent)
                      ? null
                      : () async {
                          await _scanManager.switchOutputMode(OutputMode.textBox);
                          _updateOutputMode();
                        },
                  child: const Text('Switch to TextBox'),
                ),
                TextButton(
                  onPressed: (_outputMode == OutputMode.intent)
                      ? null
                      : () async {
                          await _scanManager.switchOutputMode(OutputMode.intent);
                          _updateOutputMode();
                        },
                  child: const Text('Switch to Intent'),
                ),
              ],
            ),
            ListTile(
              title: const Text('Scanner state:'),
              trailing: Text('$_scannerState'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: !(_scannerState ?? false)
                      ? null
                      : () {
                          _scanManager.closeScanner();
                          _updateScannerState();
                        },
                  child: const Text("closeScanner"),
                ),
                TextButton(
                  onPressed: (_scannerState ?? false)
                      ? null
                      : () {
                          _scanManager.openScanner();
                          _updateScannerState();
                        },
                  child: const Text("openScanner"),
                ),
              ],
            ),
            TextButton(
              onPressed: _scanManager.startListening,
              child: const Text("Start Barcode Listening"),
            ),
            TextButton(
              onPressed: _scanManager.stopListening,
              child: const Text("Stop Barcode Listening"),
            ),
          ],
        ),
      ),
    );
  }

  void _initData() {
    _updateOutputMode();
    _updateScannerState();
  }

  void _updateScannerState() {
    _scanManager.getScannerState().then(
          (value) => setState(() => _scannerState = value),
        );
  }

  void _updateOutputMode() {
    _scanManager.getOutputMode().then(
          (value) => setState(() => _outputMode = value),
        );
  }
}
