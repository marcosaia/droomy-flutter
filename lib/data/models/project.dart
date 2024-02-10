import 'package:droomy/data/models/action_item.dart';
import 'package:droomy/data/models/action_plan.dart';
import 'package:droomy/data/models/project_state.dart';
import 'package:json_annotation/json_annotation.dart';

import 'workflow.dart';

part 'project.g.dart';

@JsonSerializable(explicitToJson: true)
class Project {
  /// Unique project identifier
  String projectId;

  /// The project title
  String title;

  /// The project workflow
  Workflow? workflow;

  /// True if the project is ready to be distributed, false otherwise
  ProjectState state;

  // Timestamp of when the project was created
  DateTime createdAt;

  // Timestamp of the last time the project was updated
  DateTime modifiedAt;

  // Utility getter for current action plan
  ActionPlan? get currentActionPlan {
    return workflow?.currentStep?.actionPlan;
  }

  // Utility getter for current action items
  List<ActionItem>? get currentActionItems {
    return currentActionPlan?.actionItems;
  }

  // Utility getter for current number of action items
  int get currentNumOfActionItems {
    return currentActionItems?.length ?? 0;
  }

  Project(
      {required this.projectId,
      required this.title,
      required this.workflow,
      required this.createdAt,
      required this.modifiedAt,
      this.state = ProjectState.workInProgress});

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
