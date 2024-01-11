import 'package:droomy/services/authentication/base/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/riverpod.dart';

import 'firebase_auth_service.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authProvider = Provider<AuthService>((ref) {
  final auth = ref.read(firebaseAuthProvider);
  return FirebaseAuthService(auth);
});