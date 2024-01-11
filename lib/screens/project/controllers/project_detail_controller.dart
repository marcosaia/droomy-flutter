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
    state = state.copyWith(project: project);
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

  addActionItemWithDescription(String description) {
    final actionItem = ActionItem(shortDescription: description);
    addActionItem(actionItem);
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

  setActionItemCompleted(ActionItem actionItem, bool completed) {
    actionItem.isCompleted = completed;
    state = state.copyWith();
  }

  updateProject() async {
    await projectRepository.update(project);
    state = state.copyWith(project: project);
  }
}
