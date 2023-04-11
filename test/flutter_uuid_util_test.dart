import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_uuid_util/flutter_uuid_util.dart';
import 'package:flutter_uuid_util/flutter_uuid_util_platform_interface.dart';
import 'package:flutter_uuid_util/flutter_uuid_util_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterUuidUtilPlatform
    with MockPlatformInterfaceMixin
    implements FlutterUuidUtilPlatform {
  @override
  Future<String?> getUuid() => Future.value('42');
}

void main() {
  final FlutterUuidUtilPlatform initialPlatform =
      FlutterUuidUtilPlatform.instance;

  test('$MethodChannelFlutterUuidUtil is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterUuidUtil>());
  });

  test('getUuid', () async {
    FlutterUuidUtil flutterUuidUtilPlugin = FlutterUuidUtil();
    MockFlutterUuidUtilPlatform fakePlatform = MockFlutterUuidUtilPlatform();
    FlutterUuidUtilPlatform.instance = fakePlatform;

    expect(await flutterUuidUtilPlugin.getUuid(), '42');
  });
}
