import 'package:droomy/models/action_item.dart';
import 'package:droomy/screens/project/widgets/action_items/project_action_items_selection_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final projectActionItemsSelectionControllerProvider = StateNotifierProvider<
    ProjectActionItemsSelectionController,
    ProjectActionItemsSelectionState>((ref) {
  return ProjectActionItemsSelectionController(
      ProjectActionItemsSelectionState.defaultState());
});

class ProjectActionItemsSelectionController
    extends StateNotifier<ProjectActionItemsSelectionState> {
  ProjectActionItemsSelectionController(super.state);

  void setActionItemSelected(ActionItem item, bool isSelected) {
    final selectedItems = Set<ActionItem>.from(state.selectedItems);

    if (isSelected) {
      selectedItems.add(item);
    } else {
      if (selectedItems.contains(item)) {
        selectedItems.remove(item);
      }
    }

    state = state.copyWith(
      selectedItems: selectedItems,
      isSelectionMode: selectedItems.isNotEmpty,
    );
  }

  void clearSelection() {
    state = state.copyWith(
      selectedItems: {},
      isSelectionMode: false,
    );
  }
}
