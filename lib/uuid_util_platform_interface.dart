import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'uuid_util_method_channel.dart';

abstract class UuidUtilPlatform extends PlatformInterface {
  /// Constructs a UuidUtilPlatform.
  UuidUtilPlatform() : super(token: _token);

  static final Object _token = Object();

  static UuidUtilPlatform _instance = MethodChannelUuidUtil();

  /// The default instance of [UuidUtilPlatform] to use.
  ///
  /// Defaults to [MethodChannelUuidUtil].
  static UuidUtilPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [UuidUtilPlatform] when
  /// they register themselves.
  static set instance(UuidUtilPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getUuid() {
    return MethodChannelUuidUtil().getUuid();
  }
}
