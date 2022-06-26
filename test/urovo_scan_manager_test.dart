import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:urovo_scan_manager/urovo_scan_manager.dart';
import 'package:urovo_scan_manager/urovo_scan_manager_method_channel.dart';
import 'package:urovo_scan_manager/urovo_scan_manager_platform_interface.dart';

class MockUrovoScanManagerPlatform
    with MockPlatformInterfaceMixin
    implements UrovoScanManagerPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final UrovoScanManagerPlatform initialPlatform =
      UrovoScanManagerPlatform.instance;

  test('$UrovoScanManagerMethodChannel is the default instance', () {
    expect(initialPlatform, isInstanceOf<UrovoScanManagerMethodChannel>());
  });

  test('getPlatformVersion', () async {
    UrovoScanManager urovoScanManagerPlugin = UrovoScanManager();
    MockUrovoScanManagerPlatform fakePlatform = MockUrovoScanManagerPlatform();
    UrovoScanManagerPlatform.instance = fakePlatform;

    expect(await urovoScanManagerPlugin.getPlatformVersion(), '42');
  });
}
