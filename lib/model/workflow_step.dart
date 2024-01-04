import 'package:json_annotation/json_annotation.dart';

import 'action_plan.dart';

part 'workflow_step.g.dart';

@JsonSerializable()
class WorkflowStep {
  /// Unique identifier of the Workflow Step.
  String identifier;

  /// The name that should be displayed for the Workflow Step.
  String displayName;

  /// An optional short description that explains what this workflow step
  /// consists of.
  String? shortDescription;

  /// An optional action plan for this workflow step
  ActionPlan? actionPlan;

  WorkflowStep(
      {required this.identifier,
      required this.displayName,
      this.actionPlan,
      this.shortDescription});

  factory WorkflowStep.fromJson(Map<String, dynamic> json) =>
      _$WorkflowStepFromJson(json);

  Map<String, dynamic> toJson() => _$WorkflowStepToJson(this);
}
