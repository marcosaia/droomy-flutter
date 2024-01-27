import '../../../models/user.dart';

abstract class AuthService {
  User? currentUser;

  Future<User?> signInWithGoogle();
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<bool> signOut();
}
