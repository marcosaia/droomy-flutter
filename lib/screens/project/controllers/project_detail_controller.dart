import 'dart:math';

import 'package:droomy/data/models/action_item.dart';
import 'package:droomy/data/models/action_plan.dart';
import 'package:droomy/data/models/project.dart';
import 'package:droomy/data/models/project_state.dart';
import 'package:droomy/screens/project/controllers/project_detail_state.dart';
import 'package:droomy/services/projects/base/project_repository.dart';
import 'package:droomy/services/projects/project_repository_provider.dart';
import 'package:riverpod/riverpod.dart';

final projectDetailControllerProvider = StateNotifierProvider.autoDispose
    .family<ProjectDetailController, ProjectDetailState, Project>(
        (ref, project) {
  return ProjectDetailController(ProjectDetailState.defaultState(),
      ref.read(projectRepositoryProvider), project);
});

class ProjectDetailController extends StateNotifier<ProjectDetailState> {
  final ProjectRepository projectRepository;
  final Project project;

  ProjectDetailController(super.state, this.projectRepository, this.project) {
    state = state.copyWith(
        project: project, areGoalsCompleted: _checkGoalsCompleted());
  }

  addActionItem(ActionItem actionItem) async {
    if (project.currentActionItems == null) {
      project.workflow?.currentStep?.actionPlan = ActionPlan(actionItems: []);
    }

    final actionItems = project.currentActionItems;
    if (actionItems == null) {
      return;
    }

    var items = List<ActionItem>.from(actionItems);
    items.add(actionItem);
    project.currentActionPlan?.actionItems = items;

    await updateProject();
  }

  addActionItemWithDescription(String description) {
    final actionItem = ActionItem(
        shortDescription: description,
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now());
    addActionItem(actionItem);
  }

  setActionItemCompleted(ActionItem actionItem, bool completed) async {
    await updateActionItem(actionItem, completed: completed);
  }

  updateActionItem(ActionItem actionItem,
      {String? shortDescription, DateTime? deadline, bool? completed}) async {
    // Update Properties
    actionItem.shortDescription =
        shortDescription ?? actionItem.shortDescription;
    actionItem.deadline = deadline ?? actionItem.deadline;
    actionItem.isCompleted = completed ?? actionItem.isCompleted;

    // Bump modified timestamp
    actionItem.modifiedAt = DateTime.now();

    await updateProject();
  }

  removeActionItems(List<ActionItem> actionItemsToRemove) async {
    final actionItems = project.currentActionItems;
    if (actionItems == null) {
      return;
    }

    var items = List<ActionItem>.from(actionItems);
    for (var element in actionItemsToRemove) {
      items.remove(element);
    }

    project.currentActionPlan?.actionItems = items;

    await updateProject();
  }

  removeActionItem(ActionItem actionItem) async {
    final actionItems = project.currentActionItems;
    if (actionItems == null) {
      return;
    }

    var items = List<ActionItem>.from(actionItems);
    items.remove(actionItem);
    project.workflow?.currentStep?.actionPlan?.actionItems = items;

    await updateProject();
  }

  swapActionItems(int oldIndex, int newIndex) async {
    final actionItems = project.currentActionItems;
    if (actionItems == null) {
      return;
    }

    // These two lines are workarounds for ReorderableListView problems
    if (newIndex > actionItems.length) {
      newIndex = actionItems.length;
    }
    if (oldIndex < newIndex) {
      newIndex--;
    }

    // Swap Action Items
    final temp = actionItems[oldIndex];
    actionItems[oldIndex] = actionItems[newIndex];
    actionItems[newIndex] = temp;

    // Update project
    project.currentActionPlan?.actionItems = actionItems;

    await updateProject();
  }

  goToNextStep() async {
    final workflow = project.workflow;
    if (workflow == null) {
      return;
    }

    // If this is the last step, set it ready for distribution
    if (workflow.currentStepIndex == workflow.steps.length - 1) {
      await completeProject();
      return;
    }

    workflow.currentStepIndex =
        min(workflow.currentStepIndex + 1, workflow.steps.length - 1);

    await updateProject();
  }

  completeProject() async {
    project.state = ProjectState.readyForDistribution;
    await updateProject();
  }

  updateProject() async {
    await projectRepository.update(project);
    state = state.copyWith(
        project: project, areGoalsCompleted: _checkGoalsCompleted());
  }

  bool _checkGoalsCompleted() {
    final actionItems = project.workflow?.currentStep?.actionPlan?.actionItems;
    if (actionItems == null) {
      return true;
    }

    return actionItems.where((element) => !element.isCompleted).isEmpty;
  }
}
