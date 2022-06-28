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
  final _outputMode = ValueNotifier<OutoutMode?>(null);
  final _scannerState = ValueNotifier<bool?>(null);

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
            ValueListenableBuilder<BarcodeDTO?>(
              valueListenable: _scanManager.barcode,
              builder: (context, barcode, _) => barcode == null
                  ? const Center(
                      child: Text('Not avalible'),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Barcode: ${barcode.value}",
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
                    ),
            ),
            const Spacer(),
            ListTile(
              title: const Text('Output mode:'),
              trailing: ValueListenableBuilder<OutoutMode?>(
                  valueListenable: _outputMode,
                  builder: (_, value, __) {
                    return Text('${value?.name}');
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () async {
                    await _scanManager.switchOutputMode(OutoutMode.intent);
                    _updateOutputMode();
                  },
                  child: const Text('Switch to Intent'),
                ),
                TextButton(
                  onPressed: () async {
                    await _scanManager.switchOutputMode(OutoutMode.textBox);
                    _updateOutputMode();
                  },
                  child: const Text('Switch to TextBox'),
                ),
              ],
            ),
            ListTile(
              title: const Text('Scanner state:'),
              trailing: ValueListenableBuilder(
                valueListenable: _scannerState,
                builder: (_, scannerState, __) {
                  return Text('$scannerState');
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    _scanManager.openScanner();
                    _updateScannerState();
                  },
                  child: const Text("openScanner"),
                ),
                TextButton(
                  onPressed: () {
                    _scanManager.closeScanner();
                    _updateScannerState();
                  },
                  child: const Text("closeScanner"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
          (value) => _scannerState.value = value,
        );
  }

  void _updateOutputMode() {
    _scanManager.getOutputMode().then(
          (value) => _outputMode.value = value,
        );
  }
}
