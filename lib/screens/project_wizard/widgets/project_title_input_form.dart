import 'package:flutter/material.dart';

import '../../../common/constants.dart';
import '../controllers/project_wizard_controller.dart';
import '../controllers/project_wizard_state.dart';

class ProjectTitleInputForm extends StatefulWidget {
  const ProjectTitleInputForm(
      {super.key,
      required this.controller,
      required this.state,
      required this.onSubmit});

  final void Function() onSubmit;
  final ProjectWizardController controller;
  final ProjectWizardState state;

  @override
  State<ProjectTitleInputForm> createState() => _ProjectTitleInputFormState();
}

class _ProjectTitleInputFormState extends State<ProjectTitleInputForm> {
  TextEditingController? _titleController;
  FocusNode? _focusNode;

  @override
  void initState() {
    _titleController = TextEditingController();
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _titleController?.dispose();
    _focusNode?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Constants.paddingRegular),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'It all starts with a name',
            // TODO: Change with theme style:
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: Constants.paddingSmall),
          const Text(
            'It doesn\'t have to be the final one, but we have to start somewhere',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: Constants.paddingBig),
          TextFormField(
            controller: _titleController,
            focusNode: _focusNode,
            maxLength: Constants.projectTitleMaxLength,
            style: Theme.of(context).textTheme.headlineMedium,
            decoration: const InputDecoration(
              labelText: 'My next project is called',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              widget.controller.setProjectTitle(value);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a title';
              }

              if (value.length < Constants.projectTitleMinLength) {
                return 'Title should be at least ${Constants.projectTitleMinLength} characters long';
              }

              if (value.length > Constants.projectTitleMaxLength) {
                return 'Title should not exceed ${Constants.projectTitleMaxLength} characters';
              }
              return null;
            },
          ),
          const SizedBox(height: Constants.paddingRegular),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: widget.state.isProjectTitleValid
                      ? () {
                          final text = _titleController?.text;
                          if (text == null) {
                            return;
                          }
                          widget.controller.setProjectTitle(text);
                          widget.onSubmit();
                        }
                      : null,
                  child: const Text('LET\'S GO'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
