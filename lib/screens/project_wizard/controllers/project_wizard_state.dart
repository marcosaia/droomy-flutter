import 'package:droomy/models/workflow.dart';
import 'package:droomy/screens/base/view_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_wizard_state.freezed.dart';

@freezed
class ProjectWizardState with _$ProjectWizardState {
  const factory ProjectWizardState({
    String? projectTitle,
    Workflow? workflow,
    @Default(false) bool isProjectTitleValid,
    required ViewState viewState,
    @Default([]) List<Workflow> workflows,
  }) = _ProjectWizardState;

  static ProjectWizardState defaultState() => const ProjectWizardState(
      projectTitle: null,
      workflow: null,
      isProjectTitleValid: false,
      viewState: ViewStateLoaded(),
      workflows: []);
}
