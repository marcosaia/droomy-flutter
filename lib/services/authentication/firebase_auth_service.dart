import 'package:droomy/services/authentication/base/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../models/user.dart' as droomy_user;
import '../storage/base/storage.dart';

class FirebaseAuthService extends AuthService {
  // Dependencies
  final FirebaseAuth _auth;
  final Storage _storage;

  final String _accessTokenKey = 'accessToken';

  FirebaseAuthService(this._auth, this._storage);

  @override
  Future<droomy_user.User?> autoSignIn() async {
    // Try to retrieve access token
    final accessToken = await _storage.readString(_accessTokenKey);
    if (accessToken == null) {
      return null;
    }

    try {
      final credentials = await _auth.signInWithCredential(
          GoogleAuthProvider.credential(accessToken: accessToken));
      final user = await getUserAndStoreToken(credentials);
      currentUser = user;
      return user;
    } catch (e) {
      // If auto-login fails we consider the token invalid and remove it from
      // storage
      await _storage.deleteString(_accessTokenKey);
      return null;
    }
  }

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

      final user = await getUserAndStoreToken(credentials);
      currentUser = user;
      return user;
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

      final user = await getUserAndStoreToken(credentials);
      currentUser = user;
      return user;
    } catch (e) {
      print("Error signing in with Email and Password: $e");
      return null;
    }
  }

  // Add other authentication methods or logic here
  @override
  Future<bool> signOut() async {
    // Sign-out from Firebase Auth
    await _auth.signOut();

    // Disconnect from google sign-in
    GoogleSignIn.standard().disconnect();

    // Invalidate currentUser
    currentUser = null;

    // Remove access token from storage
    _storage.deleteString(_accessTokenKey);

    return true;
  }

  Future<droomy_user.User?> getUserAndStoreToken(
      UserCredential? credentials) async {
    // Assert user is valid
    final user = credentials?.user;
    if (user == null) {
      return null;
    }

    // Assert Access Token is valid
    final accessToken = credentials?.credential?.accessToken;
    if (accessToken == null) {
      return null;
    }

    // Store Access Token
    await _storage.writeString(_accessTokenKey, accessToken);

    currentUser = droomy_user.User(
        uid: user.uid,
        displayName: user.displayName ?? "Dreamer",
        email: user.email,
        photoUrl: user.photoURL,
        accessToken: accessToken);

    return currentUser;
  }
}
