import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/riverpod.dart';

import 'firebase_auth_service.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authProvider = Provider<FirebaseAuthService>((ref) {
  final auth = ref.read(firebaseAuthProvider);
  return FirebaseAuthService(auth);
});
