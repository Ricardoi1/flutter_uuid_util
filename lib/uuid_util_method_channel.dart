import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'uuid_util_platform_interface.dart';

/// An implementation of [UuidUtilPlatform] that uses method channels.
class MethodChannelUuidUtil extends UuidUtilPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('uuid_util');

  @override
  Future<String?> getUuid() async {
    final version = await methodChannel.invokeMethod<String>('getUuid');
    return version;
  }
}
