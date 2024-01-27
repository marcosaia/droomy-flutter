import 'package:droomy/models/action_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_action_items_selection_state.freezed.dart';

@freezed
class ProjectActionItemsSelectionState with _$ProjectActionItemsSelectionState {
  factory ProjectActionItemsSelectionState({
    required Set<ActionItem> selectedItems,
    required bool isSelectionMode,
  }) = _ProjectActionItemsSelectionState;

  static ProjectActionItemsSelectionState defaultState() =>
      ProjectActionItemsSelectionState(
          selectedItems: {}, isSelectionMode: false);
}
