import 'package:json_annotation/json_annotation.dart';

import 'workflow_step.dart';

part 'workflow.g.dart';

@JsonSerializable()
class Workflow {
  /// The identifier of the workflow
  String identifier;

  /// The name of the workflow
  String displayName;

  /// An optional short description of the workflow
  String shortDescription = "";

  /// The list of steps that the workflow is made of
  List<WorkflowStep> steps;

  /// The current index, relative to the 'steps' and 'actionPlans' lists, of
  /// the active step in the workflow
  int currentStepIndex = -1;

  /// Utility getter for the current step
  WorkflowStep? get currentStep {
    if (currentStepIndex == -1) {
      return null;
    }
    return steps[currentStepIndex];
  }

  Workflow(
      {required this.identifier,
      required this.displayName,
      this.shortDescription = "",
      this.steps = const [],
      this.currentStepIndex = 0});

  factory Workflow.fromJson(Map<String, dynamic> json) =>
      _$WorkflowFromJson(json);

  Map<String, dynamic> toJson() => _$WorkflowToJson(this);
}
