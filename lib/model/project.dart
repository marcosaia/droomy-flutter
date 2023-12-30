import 'package:json_annotation/json_annotation.dart';

import 'action_plan.dart';
import 'workflow_step.dart';

part 'project.g.dart';

@JsonSerializable()
class Project {
  String projectId;
  WorkflowStep currentStep;
  Map<WorkflowStep, ActionPlan> actionPlans;

  Project({
    required this.projectId,
    required this.currentStep,
    required this.actionPlans,
  });

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
