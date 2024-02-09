import 'package:droomy/common/constants.dart';
import 'package:droomy/common/utils.dart';
import 'package:droomy/helpers/audio_helper.dart';
import 'package:droomy/models/action_item.dart';
import 'package:droomy/models/project.dart';
import 'package:droomy/screens/project/controllers/project_detail_controller.dart';
import 'package:droomy/screens/project/controllers/project_detail_state.dart';
import 'package:droomy/screens/project/widgets/action_items/project_action_items_list_view.dart';
import 'package:droomy/screens/project/widgets/action_items/project_action_items_selection_controller.dart';
import 'package:droomy/screens/project/widgets/dialogs/project_goal_dialog.dart';
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

  void _onPopInvoked(didPop) {
    if (!didPop) {
      return;
    }
    ref.invalidate(projectActionItemsSelectionControllerProvider);
  }

  @override
  Widget build(BuildContext context) {
    final provider = projectDetailControllerProvider(widget.project);
    final state = ref.watch(provider);
    final controller = ref.read(provider.notifier);
    final audioHelper = ref.read(audioHelperProvider);

    // Current Project
    final project = state.project;
    if (project == null) {
      Future.microtask(() => Navigator.pop(context));
      return Container();
    }

    // Current Workflow
    final workflow = project.workflow;

    // Current Workflow Action Items
    final actionItems = workflow?.currentStep?.actionPlan?.actionItems;

    // Action Items - Selection State & Controller
    final selectionState =
        ref.watch(projectActionItemsSelectionControllerProvider);
    final selectionController =
        ref.watch(projectActionItemsSelectionControllerProvider.notifier);

    // Progress Bar Value
    var progress = 0.0;
    if (workflow != null) {
      progress = (workflow.currentStepIndex + 1) / workflow.steps.length;
    }

    // Utility Variable for dispalying number of action items (goals)
    final goalsNumberDisplayText =
        '${selectionState.selectedItems.length} goal${selectionState.selectedItems.length > 1 ? 's' : ''}';

    return PopScope(
      onPopInvoked: _onPopInvoked,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.shadow,
        appBar: AppBar(
          title: selectionState.isSelectionMode
              ? Text('$goalsNumberDisplayText selected')
              : const Text('Project Detail'),
          actions: selectionState.isSelectionMode
              ? [
                  GestureDetector(
                    onTap: () {
                      showConfirmationDialog(context,
                          title: 'Confirm',
                          content:
                              'Are you sure you want to remove $goalsNumberDisplayText?',
                          onConfirm: () {
                        selectionController.clearSelection();
                        controller.removeActionItems(
                            selectionState.selectedItems.toList());
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(Constants.paddingRegular),
                      child: Icon(Icons.delete),
                    ),
                  ),
                ]
              : [],
        ),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            selectionController.clearSelection();
          },
          child: Stack(
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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                ),
                                const SizedBox(
                                    height: Constants.paddingRegular),
                                LinearProgressIndicator(
                                  value: progress,
                                ),
                                const SizedBox(
                                    height: Constants.paddingRegular),
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
                            selectionController: selectionController,
                            selectionState: selectionState,
                            actionItems: actionItems ?? [],
                            onActionItemChecked: (actionItem, isChecked) {
                              controller.setActionItemCompleted(
                                  actionItem, isChecked);
                            },
                            onActionItemEdited: (actionItem, newText) {
                              if (newText.isNotEmpty) {
                                controller.updateActionItem(actionItem,
                                    shortDescription: newText);
                              }
                            },
                            onDeadlinePressed: (actionItem) async {
                              final deadline =
                                  await _showDeadlineDialog(actionItem);
                              if (deadline != null) {
                                controller.updateActionItem(actionItem,
                                    deadline: deadline);
                              }
                            },
                            onActionItemsSwapped: (oldIndex, newIndex) async {
                              controller.swapActionItems(oldIndex, newIndex);
                            },
                          ),
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
                                          _goToNextStepPressed(
                                              controller, state, audioHelper);
                                        }
                                      : null,
                                  child: _getDoneButtonText(
                                      state.areGoalsCompleted))
                              : OutlinedButton(
                                  onPressed: () {
                                    _goToNextStepPressed(
                                        controller, state, audioHelper);
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
        ),
        floatingActionButton: selectionState.isSelectionMode
            ? null
            : Padding(
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
                            // ActionButton(
                            //     text: "Power Tools",
                            //     icon: Icon(
                            //       Icons.air,
                            //       color: Theme.of(context).colorScheme.primary,
                            //     )),
                            // const SizedBox(height: Constants.paddingBig),
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
                        isQuickActionsPanelVisible =
                            !isQuickActionsPanelVisible;
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

  Future<DateTime?> _showDeadlineDialog(ActionItem actionItem) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: actionItem.deadline,
        firstDate: currentDate.subtract(const Duration(days: 1)),
        lastDate: currentDate.add(const Duration(days: 365)));
    if (picked != null && picked != actionItem.deadline) {
      return DateTime(picked.year, picked.month, picked.day, 23, 59);
    }

    return null;
  }

  void _goToNextStepPressed(ProjectDetailController controller,
      ProjectDetailState state, AudioHelper audioHelper) {
    final numOfGoals =
        state.project?.workflow?.currentStep?.actionPlan?.actionItems.length ??
            0;

    showConfirmationDialog(context,
        title: 'Confirm',
        content: numOfGoals > 0
            ? "Well done! Are you ready to go to the next step?"
            : "You haven't added or completed any goals. Are you sure you want to go to the next step?",
        onConfirm: () {
      audioHelper.playVictorySound();
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
