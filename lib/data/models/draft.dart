import 'package:json_annotation/json_annotation.dart';

part 'draft.g.dart';

@JsonSerializable(explicitToJson: true)
class Draft {
  // The name of the draft
  String name;

  // The date of creation
  DateTime createdAt;

  // The date the draft was modified
  DateTime modifiedAt;

  // TODO: Using createdAt as the hashCode is not ideal
  @override
  bool operator ==(Object other) =>
      other is Draft && createdAt == other.createdAt;

  @override
  int get hashCode => createdAt.hashCode;

  Draft(
      {required this.name, required this.createdAt, required this.modifiedAt});
}
