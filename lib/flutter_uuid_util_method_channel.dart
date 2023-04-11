import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_uuid_util_platform_interface.dart';

/// An implementation of [FlutterUuidUtilPlatform] that uses method channels.
class MethodChannelFlutterUuidUtil extends FlutterUuidUtilPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_uuid_util');

  @override
  Future<String?> getUuid() async {
    final version = await methodChannel.invokeMethod<String>('getUuid');
    return version;
  }
}
