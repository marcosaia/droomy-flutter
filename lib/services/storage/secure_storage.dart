import 'package:droomy/services/storage/base/storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage extends Storage {
  final storage = const FlutterSecureStorage();

  @override
  Future<String?> readString(String key) {
    return storage.read(key: key);
  }

  @override
  Future<void> writeString(String key, String value) {
    return storage.write(key: key, value: value);
  }

  @override
  Future<void> deleteString(String key) {
    return storage.delete(key: key);
  }
}
