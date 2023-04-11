import 'flutter_uuid_util_platform_interface.dart';

class FlutterUuidUtil {
  Future<String?> getUuid() {
    return FlutterUuidUtilPlatform.instance.getUuid();
  }
}
