import 'package:flutter/material.dart';

Future<void> showConfirmationDialog(
  BuildContext context, {
  required String title,
  required String content,
  required VoidCallback onConfirm,
}) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Dismiss the dialog
              Navigator.of(context).pop();
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              // Dismiss the dialog and call the callback
              Navigator.of(context).pop();
              onConfirm();
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}
