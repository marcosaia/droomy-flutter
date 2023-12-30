import 'package:droomy/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/user.dart';
import '../service/firebase_authentication.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  showAlertDialog(BuildContext context, String title, String message) {
    // Set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {},
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

  onLoginSuccess(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => const MyHomePage(title: 'Overview')),
        (Route<dynamic> route) => false);
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
                User? user = await auth.signInWithGoogle();
                if (user != null) {
                  if (!context.mounted) {
                    throw StateError("Context is not mounted");
                  }
                  onLoginSuccess(context);
                }
              },
              child: const Text('Sign in with Google'),
            ),
            const SizedBox(height: 20),
            const ElevatedButton(
              onPressed: null // () async {
              // final auth = ref.read(authProvider);
              // UserCredential? userCredential =
              //     await auth.signInWithEmailAndPassword(
              //   'example@email.com',
              //   'password',
              // );
              // if (userCredential != null) {
              //   if (!context.mounted) {
              //     throw StateError("Context is not mounted");
              //   }
              //   onLoginSuccess(context);
              // }
              //}
              ,
              child: Text('Sign in with Email/Password'),
            ),
          ],
        ),
      ),
    );
  }
}
