import 'package:flutter/material.dart';

class ProjectGoalDialog extends StatefulWidget {
  final String title;
  final String action;
  final String initialValue;
  final void Function(String inputText) onConfirm;
  final void Function() onDismiss;

  const ProjectGoalDialog(
      {super.key,
      required this.title,
      required this.action,
      required this.initialValue,
      required this.onConfirm,
      required this.onDismiss});

  @override
  State<ProjectGoalDialog> createState() => _ProjectGoalDialogState();
}

class _ProjectGoalDialogState extends State<ProjectGoalDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var isValid = false;
  var inputText = "";

  @override
  void initState() {
    inputText = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Form(
        key: _formKey,
        child: TextFormField(
          initialValue: widget.initialValue,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'The text cannot be empty';
            }
            return null;
          },
          textCapitalization: TextCapitalization.sentences,
          autofocus: true,
          onChanged: (value) {
            setState(() {
              isValid = _formKey.currentState?.validate() ?? false;
              inputText = value;
            });
          },
          decoration: const InputDecoration(
            hintText: 'Enter Goal (eg. Write Lyrics)',
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: isValid
              ? () {
                  if (!(_formKey.currentState?.validate() ?? false)) {
                    return;
                  }
                  widget.onConfirm.call(inputText.trim());
                  Navigator.of(context).pop();
                  widget.onDismiss.call();
                }
              : null,
          child: Text(widget.action),
        ),
      ],
    );
  }
}
