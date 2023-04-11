import 'package:flutter_test/flutter_test.dart';
import 'package:uuid_util/uuid_util.dart';
import 'package:uuid_util/uuid_util_platform_interface.dart';
import 'package:uuid_util/uuid_util_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockUuidUtilPlatform
    with MockPlatformInterfaceMixin
    implements UuidUtilPlatform {
  @override
  Future<String?> getUuid() => Future.value('42');
}

void main() {
  final UuidUtilPlatform initialPlatform = UuidUtilPlatform.instance;

  test('$MethodChannelUuidUtil is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelUuidUtil>());
  });

  test('getPlatformVersion', () async {
    UuidUtil uuidUtilPlugin = UuidUtil();
    MockUuidUtilPlatform fakePlatform = MockUuidUtilPlatform();
    UuidUtilPlatform.instance = fakePlatform;

    expect(await uuidUtilPlugin.getUuid(), '42');
  });
}
