import 'package:droomy/common/constants.dart';
import 'package:droomy/common/theme.dart';
import 'package:droomy/common/utils.dart';
import 'package:droomy/helpers/audio_helper.dart';
import 'package:droomy/models/action_item.dart';
import 'package:droomy/models/project.dart';
import 'package:droomy/screens/project/controllers/project_detail_controller.dart';
import 'package:droomy/screens/project/widgets/action_items/project_action_items_list_view.dart';
import 'package:droomy/screens/project/widgets/action_items/project_action_items_selection_controller.dart';
import 'package:droomy/screens/project/widgets/dialogs/project_goal_dialog.dart';
import 'package:droomy/screens/project/widgets/project_detail_header_view.dart';
import 'package:droomy/widgets/action_button.dart';
import 'package:droomy/widgets/actions_floating_button.dart';
import 'package:droomy/widgets/opacity_touch_overlay.dart';
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

  bool get _isFloatingButtonVisible {
    final selectionState =
        ref.read(projectActionItemsSelectionControllerProvider);
    return !selectionState.isSelectionMode;
  }

  @override
  Widget build(BuildContext context) {
    final provider = projectDetailControllerProvider(widget.project);
    final state = ref.watch(provider);
    final controller = ref.read(provider.notifier);

    // Current Project
    final project = state.project;
    if (project == null) {
      Future.microtask(() => Navigator.pop(context));
      return Container();
    }

    // Action Items - Selection State & Controller
    final selectionState =
        ref.watch(projectActionItemsSelectionControllerProvider);
    final selectionController =
        ref.watch(projectActionItemsSelectionControllerProvider.notifier);

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
                      // Header View
                      ProjectDetailHeaderView(project: project),
                      // Action Items Header View
                      Padding(
                        padding: const EdgeInsets.all(Constants.paddingRegular),
                        child: Text("Your plan",
                            style: Theme.of(context).textTheme.headlineMedium),
                      ),
                      // Action Items List View
                      Padding(
                        padding: const EdgeInsets.all(Constants.paddingRegular),
                        child: Column(
                          children: [
                            ProjectActionItemsListView(
                              selectionController: selectionController,
                              selectionState: selectionState,
                              actionItems: project.currentActionItems ?? [],
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
                            project.currentNumOfActionItems > 0
                                ? ElevatedButton(
                                    style: state.areGoalsCompleted
                                        ? context.primaryContainerBgButtonStyle
                                        : null,
                                    onPressed: state.areGoalsCompleted
                                        ? () {
                                            _goToNextStepPressed();
                                          }
                                        : null,
                                    child: _getDoneButtonText(
                                        state.areGoalsCompleted))
                                : OutlinedButton(
                                    onPressed: () {
                                      _goToNextStepPressed();
                                    },
                                    child: _getDoneButtonText(
                                        state.areGoalsCompleted)),
                            const SizedBox(
                                height: Constants.paddingIncrediblyBig),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                OpacityTouchOverlay(
                  isOverlayVisible: isQuickActionsPanelVisible,
                  onOverlayTouched: () {
                    setState(() {
                      isQuickActionsPanelVisible = false;
                    });
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: _isFloatingButtonVisible
              ? ActionsFloatingButton(
                  isActionsPanelVisible: isQuickActionsPanelVisible,
                  onFloatingButtonTap: () {
                    setState(() {
                      isQuickActionsPanelVisible = !isQuickActionsPanelVisible;
                    });
                  },
                  actionButtons: [
                      ActionButton(
                          onPressed: () {
                            _showAddGoalDialog();
                          },
                          text: "Add a goal",
                          icon: Icon(
                            Icons.add_task,
                            color: Theme.of(context).colorScheme.primary,
                          )),
                    ])
              : null,
        ));
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

  void _goToNextStepPressed() {
    final provider = projectDetailControllerProvider(widget.project);
    final state = ref.read(provider);

    // Assert project is not null
    final project = state.project;
    if (project == null) {
      return;
    }

    showConfirmationDialog(context,
        title: 'Confirm',
        content: project.currentNumOfActionItems > 0
            ? "Well done! Are you ready to go to the next step?"
            : "You haven't added or completed any goals. Are you sure you want to go to the next step?",
        onConfirm: () {
      ref.read(audioHelperProvider).playVictorySound();
      ref.read(provider.notifier).goToNextStep();
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

  void _showAddGoalDialog() {
    final controller =
        ref.read(projectDetailControllerProvider(widget.project).notifier);
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
