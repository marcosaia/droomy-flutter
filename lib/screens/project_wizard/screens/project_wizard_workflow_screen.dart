import 'package:droomy/screens/project_wizard/controllers/project_wizard_controller.dart';
import 'package:droomy/screens/project_wizard/widgets/workflow_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/workflow.dart';
import 'project_wizard_confirmation_screen.dart';

class WorkflowListScreen extends ConsumerStatefulWidget {
  const WorkflowListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return WorkflowListScreenState();
  }
}

class WorkflowListScreenState extends ConsumerState<WorkflowListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(projectWizardControllerProvider);
    var controller = ref.read(projectWizardControllerProvider.notifier);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Choose your dream flow'),
        ),
        body: state.viewState.map(
          loaded: (value) =>
              getWorkflowsListWidget(context, controller, state.workflows),
          error: (value) => getErrorWidget('Unexpected error.'),
          loading: (value) => getLoadingWidget(),
        ));
  }

  Widget getWorkflowsListWidget(
      final BuildContext context,
      final ProjectWizardController controller,
      final List<Workflow> workflows) {
    return WorkflowListView(
        workflows: workflows,
        onTap: (Workflow workflow) {
          controller.setWorkflow(workflow);
          _navigateToNextScreen();
        });
  }

  Widget getEmptyWorkflowsListWidget() {
    return const Center(child: Text('No workflows found.'));
  }

  Widget getLoadingWidget() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget getErrorWidget(final Object error) {
    return Center(child: Text('Error: $error'));
  }

  void _navigateToNextScreen() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            const ConfirmationScreen(title: "Are you ready?")));
  }
}
