import 'package:droomy/common/constants.dart';
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

void showMessageOverlay(BuildContext context,
    {required String message, int seconds = 2}) {
  OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: Constants.paddingBig,
      left: Constants.paddingBig,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.paddingRegular,
              vertical: Constants.paddingSmall),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  );

  Overlay.of(context).insert(overlayEntry);

  Future.delayed(Duration(seconds: seconds), () {
    overlayEntry.remove();
  });
}
