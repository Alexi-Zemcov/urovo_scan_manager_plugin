import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:urovo_scan_manager/urovo_scan_manager_method_channel.dart';

void main() {
  UrovoScanManagerMethodChannel platform = UrovoScanManagerMethodChannel();
  const MethodChannel channel = MethodChannel('urovo_scan_manager');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
