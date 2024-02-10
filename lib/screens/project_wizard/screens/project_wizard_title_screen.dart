import 'package:droomy/screens/project_wizard/controllers/project_wizard_controller.dart';
import 'package:droomy/screens/project_wizard/screens/project_wizard_confirmation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/project_title_input_form.dart';

class TitleInputScreen extends ConsumerStatefulWidget {
  const TitleInputScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return TitleInputScreenState();
  }
}

class TitleInputScreenState extends ConsumerState<TitleInputScreen> {
  final TextEditingController _titleController = TextEditingController();
  bool isNextButtonEnabled = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _onPopInvoked(didPop) {
    if (!didPop) {
      return;
    }
    ref.invalidate(projectWizardControllerProvider);
  }

  @override
  Widget build(BuildContext context) {
    var controller = ref.read(projectWizardControllerProvider.notifier);
    var state = ref.watch(projectWizardControllerProvider);

    return PopScope(
      onPopInvoked: _onPopInvoked,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Start a new song'),
          ),
          body: SingleChildScrollView(
            child: ProjectTitleInputForm(
              controller: controller,
              state: state,
              onSubmit: () async {
                await controller.setDefaultWorkflow();
                if (!context.mounted) {
                  return;
                }
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) =>
                        const ProjectWizardConfirmationScreen())));
              },
            ),
          )),
    );
  }
}
