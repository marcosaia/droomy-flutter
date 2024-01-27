import 'dart:math';

import 'package:droomy/models/action_item.dart';
import 'package:droomy/models/action_plan.dart';
import 'package:droomy/models/project.dart';
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

  // Private utility getters
  ActionPlan? get _actionPlan => project.workflow?.currentStep?.actionPlan;

  addActionItem(ActionItem actionItem) async {
    if (_actionPlan?.actionItems == null) {
      print("Creating project Action Plan");
      project.workflow?.currentStep?.actionPlan = ActionPlan(actionItems: []);
    }

    final actionItems = _actionPlan?.actionItems;
    if (actionItems == null) {
      return;
    }

    var items = List<ActionItem>.from(actionItems);
    items.add(actionItem);
    project.workflow?.currentStep?.actionPlan?.actionItems = items;

    await updateProject();
  }

  goToNextStep() async {
    final workflow = project.workflow;
    if (workflow == null) {
      return;
    }
    workflow.currentStepIndex =
        min(workflow.currentStepIndex + 1, workflow.steps.length - 1);

    await updateProject();
  }

  addActionItemWithDescription(String description) {
    final actionItem = ActionItem(shortDescription: description);
    addActionItem(actionItem);
  }

  removeActionItems(List<ActionItem> actionItemsToRemove) async {
    final actionItems = _actionPlan?.actionItems;
    if (actionItems == null) {
      return;
    }

    var items = List<ActionItem>.from(actionItems);
    for (var element in actionItemsToRemove) {
      items.remove(element);
    }

    project.workflow?.currentStep?.actionPlan?.actionItems = items;

    await updateProject();
  }

  removeActionItem(ActionItem actionItem) async {
    final actionItems = _actionPlan?.actionItems;
    if (actionItems == null) {
      return;
    }

    var items = List<ActionItem>.from(actionItems);
    items.remove(actionItem);
    project.workflow?.currentStep?.actionPlan?.actionItems = items;

    await updateProject();
  }

  setActionItemCompleted(ActionItem actionItem, bool completed) async {
    actionItem.isCompleted = completed;
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
