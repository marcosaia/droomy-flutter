import 'package:droomy/screens/project_wizard/controllers/project_wizard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/project_title_input_form.dart';
import 'project_wizard_workflow_screen.dart';

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
            title: const Text('Start a new project'),
          ),
          body: SingleChildScrollView(
            child: ProjectTitleInputForm(
              controller: controller,
              state: state,
              onSubmit: () {
                controller.fetchWorkflows();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const WorkflowListScreen())));
              },
            ),
          )),
    );
  }
}
