import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid_util/uuid_util_method_channel.dart';

void main() {
  MethodChannelUuidUtil platform = MethodChannelUuidUtil();
  const MethodChannel channel = MethodChannel('uuid_util');

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
    expect(await platform.getUuid(), '42');
  });
}
