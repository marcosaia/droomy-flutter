import 'package:json_annotation/json_annotation.dart';

part 'action_item.g.dart';

@JsonSerializable()
class ActionItem {
  /// The short description of the action item
  String shortDescription;

  /// The optional long description of the action item
  String? longDescription;

  /// The optional deadline of the action item
  DateTime? deadline;

  ActionItem({
    required this.shortDescription,
    this.longDescription,
    this.deadline,
  });

  factory ActionItem.fromJson(Map<String, dynamic> json) =>
      _$ActionItemFromJson(json);

  Map<String, dynamic> toJson() => _$ActionItemToJson(this);
}
