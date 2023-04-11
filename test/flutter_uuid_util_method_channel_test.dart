import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_uuid_util/flutter_uuid_util_method_channel.dart';

void main() {
  MethodChannelFlutterUuidUtil platform = MethodChannelFlutterUuidUtil();
  const MethodChannel channel = MethodChannel('flutter_uuid_util');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getUuid', () async {
    expect(await platform.getUuid(), '42');
  });
}
