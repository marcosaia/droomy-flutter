import 'package:json_annotation/json_annotation.dart';

import 'workflow.dart';

part 'project.g.dart';

@JsonSerializable()
class Project {
  /// Unique project identifier
  String projectId;

  /// The project title
  String title;

  /// The project workflow
  Workflow? workflow;

  Project({required this.projectId, required this.title, this.workflow});

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
