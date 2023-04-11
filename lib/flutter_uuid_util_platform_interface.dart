import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_uuid_util_method_channel.dart';

abstract class FlutterUuidUtilPlatform extends PlatformInterface {
  /// Constructs a FlutterUuidUtilPlatform.
  FlutterUuidUtilPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterUuidUtilPlatform _instance = MethodChannelFlutterUuidUtil();

  /// The default instance of [FlutterUuidUtilPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterUuidUtil].
  static FlutterUuidUtilPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterUuidUtilPlatform] when
  /// they register themselves.
  static set instance(FlutterUuidUtilPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getUuid() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
