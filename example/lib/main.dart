import 'package:flutter/material.dart';
import 'package:urovo_scan_manager/dto/barcode_dto.dart';
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
  final _urovoScanManagerPlugin = UrovoScanManager();
  int? _outputMode;

  bool? _scannerState;

  @override
  void initState() {
    super.initState();
    _getData();
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
              valueListenable: _urovoScanManagerPlugin.barcode,
              builder: (context, value, _) => ListTile(
                subtitle: Text(
                  ((value?.toJson()) ?? "Not avalible").toString(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Spacer(),
            ListTile(
              title: const Text('Output mode:'),
              trailing: Text('$_outputMode'),
            ),
            ListTile(
              title: const Text('Scanner state:'),
              trailing: Text('$_scannerState'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    _urovoScanManagerPlugin.openScanner();
                    _getData();
                  },
                  child: const Text("openScanner"),
                ),
                TextButton(
                  onPressed: () {
                    _urovoScanManagerPlugin.closeScanner();
                    _getData();
                  },
                  child: const Text("closeScanner"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: _urovoScanManagerPlugin.startListening,
                  child: const Text("Start Barcode Listening"),
                ),
                TextButton(
                  onPressed: _urovoScanManagerPlugin.stopListening,
                  child: const Text("Stop Barcode Listening"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _getData() {
    _urovoScanManagerPlugin.getOutputMode().then(
          (value) => setState(() => {_outputMode = value}),
        );
    _urovoScanManagerPlugin.getScannerState().then(
          (value) => setState(() => {_scannerState = value}),
        );
  }
}
