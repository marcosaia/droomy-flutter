import 'package:droomy/service/authentication/base/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../model/user.dart' as droomy_user;

class FirebaseAuthService extends AuthService {
  final FirebaseAuth _auth;
  droomy_user.User? currentUser;

  FirebaseAuthService(this._auth);

  @override
  Future<droomy_user.User?> signInWithGoogle() async {
    final GoogleSignIn signIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? account = await signIn.signIn();
      if (account == null) {
        return null;
      }

      final GoogleSignInAuthentication authentication =
          await account.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken,
      );

      final UserCredential credentials =
          await _auth.signInWithCredential(credential);

      return getUserFromCredentials(credentials);
    } catch (e) {
      print("Error signing in with Google: $e");
    }

    return null;
  }

  // Implement Firebase email/password login method
  @override
  Future<droomy_user.User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential? credentials = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return getUserFromCredentials(credentials);
    } catch (e) {
      print("Error signing in with Email and Password: $e");
      return null;
    }
  }

  // Add other authentication methods or logic here
  @override
  Future<bool> signOut() async {
    await _auth.signOut();
    return true;
  }

  droomy_user.User? getUserFromCredentials(UserCredential? credentials) {
    final User? user = credentials?.user;

    if (user == null) {
      return null;
    }

    currentUser = droomy_user.User(
        uid: user.uid,
        displayName: user.displayName ?? "Dreamer",
        email: user.email,
        photoUrl: user.photoURL);

    return currentUser;
  }
}
