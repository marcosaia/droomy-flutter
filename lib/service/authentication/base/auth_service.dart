import '../../../model/user.dart';

abstract class AuthService {
  Future<User?> signInWithGoogle();
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<bool> signOut();
}
