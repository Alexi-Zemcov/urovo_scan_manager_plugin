import 'package:flutter/material.dart';
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
          children: [
            Text('Output mode: $_outputMode'),
            Text('Scanner state: $_scannerState'),
            TextButton(
              onPressed: _urovoScanManagerPlugin.openScanner,
              child: const Text("openScanner"),
            ),
            TextButton(
              onPressed: _urovoScanManagerPlugin.closeScanner,
              child: const Text("closeScanner"),
            ),
            TextButton(
              onPressed: _urovoScanManagerPlugin.startListening,
              child: const Text("Start Listening"),
            ),
            TextButton(
              onPressed: _urovoScanManagerPlugin.stopListening,
              child: const Text("Stop Listening"),
            ),
            ValueListenableBuilder<String?>(
              valueListenable: _urovoScanManagerPlugin.barcode,
              builder: (context, value, _) => Text(((value) ?? "Not avalible").toString()),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _getData(),
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
