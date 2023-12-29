
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod/riverpod.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authProvider = Provider<FirebaseAuthentication>((ref) {
  final auth = ref.read(firebaseAuthProvider);
  return FirebaseAuthentication(auth);
});

class FirebaseAuthentication {
  final FirebaseAuth _auth;

  FirebaseAuthentication(this._auth);

  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignIn signIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? account = await signIn.signIn();
      if (account == null) {
        return null;
      }

      final GoogleSignInAuthentication authentication = await account.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken,
      );
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      print("Error signing in with Google: $e");
    }

    return null;
  }

  // Implement Firebase email/password login method
  Future<UserCredential?> signInWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print("Error signing in with Email and Password: $e");
      return null;
    }
  }

  // Add other authentication methods or logic here

  Future<void> signOut() async {
    await _auth.signOut();
  }
}