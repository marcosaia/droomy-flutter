abstract class Storage {
  Future<void> writeString(String key, String value);
  Future<String?> readString(String key);
  Future<void> deleteString(String key);
}
