import 'package:json_annotation/json_annotation.dart';

part 'action_item.g.dart';

@JsonSerializable()
class ActionItem {
  String shortDescription;
  String longDescription;
  DateTime? deadline;

  ActionItem({
    required this.shortDescription,
    this.longDescription = "",
    this.deadline,
  });

  factory ActionItem.fromJson(Map<String, dynamic> json) =>
      _$ActionItemFromJson(json);

  Map<String, dynamic> toJson() => _$ActionItemToJson(this);
}
