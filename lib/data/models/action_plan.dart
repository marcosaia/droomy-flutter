import 'package:json_annotation/json_annotation.dart';

import 'action_item.dart';

part 'action_plan.g.dart';

@JsonSerializable(explicitToJson: true)
class ActionPlan {
  List<ActionItem> actionItems;
  DateTime? mainDeadline;

  ActionPlan({
    this.mainDeadline,
    this.actionItems = const [],
  });

  factory ActionPlan.fromJson(Map<String, dynamic> json) =>
      _$ActionPlanFromJson(json);

  Map<String, dynamic> toJson() => _$ActionPlanToJson(this);
}
