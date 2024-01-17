import 'package:audioplayers/audioplayers.dart';
import 'package:droomy/common/constants.dart';
import 'package:droomy/common/utils.dart';
import 'package:droomy/models/action_item.dart';
import 'package:droomy/models/project.dart';
import 'package:droomy/screens/project/controllers/project_detail_controller.dart';
import 'package:droomy/screens/project/controllers/project_detail_state.dart';
import 'package:droomy/screens/project/widgets/project_action_items_list_view.dart';
import 'package:droomy/widgets/action_button.dart';
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
  var isQuickActionsPanelVisible = false;
  Set<ActionItem> _selectedItems = {};
  bool get _isSelectionMode => _selectedItems.isNotEmpty;

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

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.shadow,
        appBar: AppBar(
          title: _isSelectionMode
              ? Text(
                  '${_selectedItems.length} goal${_selectedItems.length > 1 ? 's' : ''} selected')
              : const Text('Project Detail'),
          actions: _isSelectionMode
              ? [
                  const Padding(
                    padding: EdgeInsets.all(Constants.paddingRegular),
                    child: Icon(Icons.delete),
                  ),
                ]
              : [],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
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
                                  textAlign: TextAlign.center,
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
                                project.workflow?.currentStep?.displayName ??
                                    "-",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                              const SizedBox(height: Constants.paddingRegular),
                              LinearProgressIndicator(
                                value: progress,
                              ),
                              const SizedBox(height: Constants.paddingRegular),
                              Text(project.workflow?.currentStep
                                      ?.shortDescription ??
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
                            onActionItemChecked: (actionItem, isChecked) {
                              controller.setActionItemCompleted(
                                  actionItem, isChecked);
                            },
                            onActionItemEdited: (actionItem, newText) {
                              if (newText.isNotEmpty) {
                                actionItem.shortDescription = newText;
                                controller.updateProject();
                              }
                            },
                            onActionItemSelected: (selectedItems) {
                              _selectedItems = selectedItems;
                              setState(() {});
                            }),
                        const SizedBox(height: Constants.paddingBig),
                        (actionItems?.length ?? 0) > 0
                            ? ElevatedButton(
                                style: state.areGoalsCompleted
                                    ? Theme.of(context)
                                        .elevatedButtonTheme
                                        .style
                                        ?.copyWith(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primaryContainer))
                                    : null,
                                onPressed: state.areGoalsCompleted
                                    ? () {
                                        _goToNextStepPressed(controller, state);
                                      }
                                    : null,
                                child:
                                    _getDoneButtonText(state.areGoalsCompleted))
                            : OutlinedButton(
                                onPressed: () {
                                  _goToNextStepPressed(controller, state);
                                },
                                child: _getDoneButtonText(
                                    state.areGoalsCompleted)),
                        const SizedBox(height: 64.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (!isQuickActionsPanelVisible) {
                  return;
                }
                isQuickActionsPanelVisible = false;
                setState(() {});
              },
              child: IgnorePointer(
                ignoring: !isQuickActionsPanelVisible,
                child: Opacity(
                  opacity: isQuickActionsPanelVisible ? 0.9 : 0,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Theme.of(context).colorScheme.background,
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(Constants.paddingSmall),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IgnorePointer(
                ignoring: !isQuickActionsPanelVisible,
                child: Opacity(
                  opacity: isQuickActionsPanelVisible ? 1 : 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ActionButton(
                          text: "Power Tools",
                          icon: Icon(
                            Icons.air,
                            color: Theme.of(context).colorScheme.primary,
                          )),
                      const SizedBox(height: Constants.paddingBig),
                      ActionButton(
                          onPressed: () {
                            _showAddGoalDialog(controller);
                          },
                          text: "Add a goal",
                          icon: Icon(
                            Icons.add_task,
                            color: Theme.of(context).colorScheme.primary,
                          )),
                      const SizedBox(height: Constants.paddingBig),
                    ],
                  ),
                ),
              ),
              FloatingActionButton(
                onPressed: () {
                  isQuickActionsPanelVisible = !isQuickActionsPanelVisible;
                  setState(() {});
                },
                child: isQuickActionsPanelVisible
                    ? const Icon(Icons.close)
                    : const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _goToNextStepPressed(
      ProjectDetailController controller, ProjectDetailState state) {
    final numOfGoals =
        state.project?.workflow?.currentStep?.actionPlan?.actionItems.length ??
            0;
    showConfirmationDialog(context,
        title: 'Confirm',
        content: numOfGoals > 0
            ? "Well done! Are you ready to go to the next step?"
            : "You haven't added or completed any goals. Are you sure you want to go to the next step?",
        onConfirm: () {
      AudioPlayer().play(AssetSource('sounds/sfx_step_completed_success.mp3'));
      controller.goToNextStep();
    });
  }

  Widget _getDoneButtonText(bool areGoalsCompleted) {
    return Text(
      "GO TO NEXT STEP",
      style: areGoalsCompleted
          ? Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryContainer)
          : null,
    );
  }

  void _showEditGoalDialog(
      ProjectDetailController controller, ActionItem actionItem) {
    showDialog(
        context: context,
        builder: (context) {
          return ProjectGoalDialog(
              title: "Edit goal",
              action: "SAVE",
              initialValue: actionItem.shortDescription,
              onConfirm: (text) {
                if (text.isNotEmpty) {
                  actionItem.shortDescription = text;
                  controller.updateProject();
                }
              },
              onDismiss: () {
                isQuickActionsPanelVisible = false;
                setState(() {});
              });
        });
  }

  void _showAddGoalDialog(ProjectDetailController controller) {
    showDialog(
        context: context,
        builder: (context) {
          return ProjectGoalDialog(
              title: "Add new goal",
              action: "ADD",
              initialValue: "",
              onConfirm: (text) {
                if (text.isNotEmpty) {
                  controller.addActionItemWithDescription(text);
                }
              },
              onDismiss: () {
                isQuickActionsPanelVisible = false;
                setState(() {});
              });
        });
  }
}

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
