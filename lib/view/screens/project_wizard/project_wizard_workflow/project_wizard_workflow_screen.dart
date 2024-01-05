import 'package:droomy/view/screens/project_wizard/project_wizard_confirmation/project_wizard_confirmation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../model/workflow.dart';
import '../../../../service/workflows/workflow_repository_provider.dart';
import '../../../../widget/themed_html_text.dart';

class WorkflowListScreen extends ConsumerStatefulWidget {
  final String projectTitle;

  const WorkflowListScreen({super.key, required this.projectTitle});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return WorkflowListScreenState();
  }
}

class WorkflowListScreenState extends ConsumerState<WorkflowListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(workflowRepositoryProvider);
    });
  }

  String getStepsDisplayText(Workflow workflow) {
    return workflow.steps.map((step) => step.displayName).join(', ');
  }

  @override
  Widget build(BuildContext context) {
    final defaultWorkflows = ref.watch(defaultWorkflowsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose your dream flow'),
      ),
      body: defaultWorkflows.when(
        data: (workflows) {
          if (workflows.isEmpty) {
            return const Center(child: Text('No workflows found.'));
          } else {
            return ListView.separated(
              itemCount: workflows.length,
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(); // Add a Divider between list items
              },
              itemBuilder: (context, index) {
                Workflow workflow = workflows[index];
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListTile(
                        title: Text(
                          workflow.displayName,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            ThemedHtmlText(
                                htmlContent: workflow.shortDescription
                                    .replaceAll('\\n', '\n')),
                            const SizedBox(height: 8),
                            Text('Steps',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)),
                            Text(
                              getStepsDisplayText(workflow),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                      color: Theme.of(context).hintColor),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                              ConfirmationScreen(
                                  title: "Are you ready?",
                                  projectName: widget.projectTitle,
                                  workflow: workflow)));
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
