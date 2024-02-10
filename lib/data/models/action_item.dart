import 'package:json_annotation/json_annotation.dart';

part 'action_item.g.dart';

@JsonSerializable(explicitToJson: true)
class ActionItem {
  /// The short description of the action item
  String shortDescription;

  /// The optional long description of the action item
  String? longDescription;

  /// The optional deadline of the action item
  DateTime? deadline;

  /// True if the action item has been completed, false otherwise
  bool isCompleted;

  /// The date the action item was created at
  DateTime createdAt;

  /// The date the action item was modified at
  DateTime modifiedAt;

  // TODO: Using createdAt as the hashCode is not ideal
  @override
  bool operator ==(Object other) =>
      other is ActionItem && createdAt == other.createdAt;

  @override
  int get hashCode => createdAt.hashCode;

  ActionItem({
    required this.shortDescription,
    required this.createdAt,
    required this.modifiedAt,
    this.longDescription,
    this.deadline,
    this.isCompleted = false,
  });

  factory ActionItem.simpleGoal(String description) {
    return ActionItem(
        shortDescription: description,
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now());
  }

  factory ActionItem.fromJson(Map<String, dynamic> json) =>
      _$ActionItemFromJson(json);

  Map<String, dynamic> toJson() => _$ActionItemToJson(this);
}
