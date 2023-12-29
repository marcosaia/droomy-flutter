import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import '../service/firebase_authentication.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  showAlertDialog(BuildContext context, String title, String message) {

    // Set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () { },
    );

    // Set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // Show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                final auth = ref.read(authProvider);
                UserCredential? userCredential = await auth.signInWithGoogle();
                if (userCredential != null) {
                  showAlertDialog(context, "INFO", "Login with google OK.");
                }
              },
              child: const Text('Sign in with Google'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final auth = ref.read(authProvider);
                UserCredential? userCredential = await auth.signInWithEmailAndPassword(
                  'example@email.com',
                  'password',
                );
                if (userCredential != null) {
                  // Successfully signed in with email and password
                  // Navigate to the next screen or perform desired operations
                }
              },
              child: const Text('Sign in with Email/Password'),
            ),
          ],
        ),
      ),
    );
  }
}