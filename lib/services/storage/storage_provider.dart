import 'package:droomy/services/storage/base/storage.dart';
import 'package:droomy/services/storage/secure_storage.dart';
import 'package:riverpod/riverpod.dart';

final storageProvider = Provider<Storage>((ref) {
  return SecureStorage();
});
