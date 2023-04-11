import 'uuid_util_platform_interface.dart';

class UuidUtil {
  Future<String?> getUuid() {
    return UuidUtilPlatform.instance.getUuid();
  }
}
