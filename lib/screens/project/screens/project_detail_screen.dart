import 'package:droomy/common/constants.dart';
import 'package:droomy/common/utils.dart';
import 'package:droomy/models/action_item.dart';
import 'package:droomy/models/project.dart';
import 'package:droomy/screens/project/controllers/project_detail_controller.dart';
import 'package:droomy/screens/project/widgets/project_action_items_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProjectDetailScreen extends ConsumerStatefulWidget {
  final Project project;

  const ProjectDetailScreen({super.key, required this.project});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return ProjectDetailScreenState();
  }
}

class ProjectDetailScreenState extends ConsumerState<ProjectDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = projectDetailControllerProvider(widget.project);
    final state = ref.watch(provider);
    final controller = ref.read(provider.notifier);
    final project = state.project;
    if (project == null) {
      Future.microtask(() => Navigator.pop(context));
      return Container();
    }

    final workflow = project.workflow;
    final actionItems = workflow?.currentStep?.actionPlan?.actionItems;

    var progress = 0.0;
    if (workflow != null) {
      progress = (workflow.currentStepIndex + 1) / workflow.steps.length;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.shadow,
      appBar: AppBar(
        title: const Text('Project Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Theme.of(context).colorScheme.shadow,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      children: [
                        Hero(
                          tag: "project_title_${project.projectId}",
                          child: Text(
                            project.title,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                          ),
                        ),
                        const SizedBox(height: Constants.paddingSmall),
                        Text(
                          project.workflow?.currentStep?.displayName ?? "-",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        const SizedBox(height: Constants.paddingRegular),
                        LinearProgressIndicator(
                          value: progress,
                        ),
                        const SizedBox(height: Constants.paddingRegular),
                        Text(project.workflow?.currentStep?.shortDescription ??
                            "-"),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Constants.paddingRegular),
              child: Text("Your plan",
                  style: Theme.of(context).textTheme.headlineMedium),
            ),
            Padding(
              padding: const EdgeInsets.all(Constants.paddingRegular),
              child: Column(
                children: [
                  ProjectActionItemsListView(
                      actionItems: actionItems ?? [],
                      onCheckboxPressed: (actionItem, value) {
                        controller.setActionItemCompleted(actionItem, value);
                      },
                      onEditIconPressed: (actionItem) {
                        _showEditDialog(controller, actionItem);
                      },
                      onDeleteIconPressed: (actionItem) {
                        if (!context.mounted) {
                          return;
                        }
                        showConfirmationDialog(context,
                            title: 'Confirm',
                            content:
                                'Are you sure you want to remove this action item?',
                            onConfirm: () {
                          controller.removeActionItem(actionItem);
                        });
                      }),
                  const SizedBox(height: 64.0),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(Constants.paddingSmall),
        child: FloatingActionButton(
          onPressed: () {
            _showAddTodoDialog(controller);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _showEditDialog(
      ProjectDetailController controller, ActionItem actionItem) {
    var newText = actionItem.shortDescription;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Todo Item'),
          content: TextFormField(
            initialValue: newText,
            onChanged: (value) {
              newText = value;
            },
            decoration: const InputDecoration(
              hintText: 'Enter Todo Item',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  if (newText.isNotEmpty) {
                    actionItem.shortDescription = newText;
                    controller.updateProject();
                  }
                });
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showAddTodoDialog(ProjectDetailController controller) {
    String newTodo = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Todo Item'),
          content: TextFormField(
            onChanged: (value) {
              newTodo = value;
            },
            decoration: const InputDecoration(
              hintText: 'Enter Todo Item',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  if (newTodo.isNotEmpty) {
                    controller.addActionItemWithDescription(newTodo);
                  }
                });
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
