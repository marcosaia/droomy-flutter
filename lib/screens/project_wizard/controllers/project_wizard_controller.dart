import 'package:droomy/common/constants.dart';
import 'package:droomy/models/workflow.dart';
import 'package:droomy/screens/base/view_state.dart';
import 'package:droomy/services/projects/project_repository_provider.dart';
import 'package:droomy/services/workflows/base/workflow_repository.dart';
import 'package:droomy/services/workflows/workflow_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/project.dart';
import '../../../services/projects/base/project_repository.dart';
import 'project_wizard_state.dart';

final projectWizardControllerProvider =
    StateNotifierProvider<ProjectWizardController, ProjectWizardState>((ref) {
  return ProjectWizardController(
      ProjectWizardState.defaultState(),
      ref.read(projectRepositoryProvider),
      ref.read(workflowRepositoryProvider));
});

class ProjectWizardController extends StateNotifier<ProjectWizardState> {
  // Dependencies
  final ProjectRepository _projectRepository;
  final WorkflowRepository _workflowRepository;

  ProjectWizardController(
      super.state, this._projectRepository, this._workflowRepository);

  // ------------------------------------------------------
  // Step 1 - Project Basic Info (title, description etc.)
  // ------------------------------------------------------
  void setProjectTitle(final String title) {
    state = state.copyWith(
        projectTitle: title, isProjectTitleValid: validateTitle(title));
  }

  bool validateTitle(final String title) {
    return title.length >= Constants.projectTitleMinLength &&
        title.length <= Constants.projectTitleMaxLength;
  }

  // ------------------------------------------------------
  // Step 2 - Workflow Selection
  // ------------------------------------------------------
  Future<void> fetchWorkflows() async {
    // Set loading state
    state = state.copyWith(viewState: const ViewStateLoading());

    // Fetch Workflows and update state
    var workflows = await _workflowRepository.getDefaultWorkflows();
    state = state.copyWith(
        workflows: workflows, viewState: const ViewStateLoaded());
  }

  void setWorkflow(Workflow workflow) {
    state = state.copyWith(workflow: workflow);
  }

  // ------------------------------------------------------
  // Step 3 - Finalizing
  // ------------------------------------------------------
  Future<bool> createProject(
      final String title, final Workflow workflow) async {
    Project project = Project(
      title: title,
      workflow: workflow,
      createdAt: DateTime.now(),
      modifiedAt: DateTime.now(),
      projectId: '', // Auto-Generated with Firestore
    );

    return await _projectRepository.add(project);
  }
}
