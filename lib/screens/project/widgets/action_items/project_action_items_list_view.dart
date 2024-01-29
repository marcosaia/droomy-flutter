import 'package:droomy/common/constants.dart';
import 'package:droomy/models/action_item.dart';
import 'package:droomy/screens/project/widgets/action_items/project_action_item_view.dart';
import 'package:droomy/screens/project/widgets/action_items/project_action_items_selection_controller.dart';
import 'package:droomy/screens/project/widgets/action_items/project_action_items_selection_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProjectActionItemsListView extends StatefulWidget {
  final List<ActionItem> actionItems;
  final ProjectActionItemsSelectionController selectionController;
  final ProjectActionItemsSelectionState selectionState;
  final void Function(ActionItem actionItem, String newText) onActionItemEdited;
  final void Function(ActionItem actionItem, bool isChecked)
      onActionItemChecked;
  final void Function(ActionItem actionItem)? onDeadlinePressed;

  const ProjectActionItemsListView({
    super.key,
    required this.actionItems,
    required this.selectionController,
    required this.selectionState,
    required this.onActionItemEdited,
    required this.onActionItemChecked,
    this.onDeadlinePressed,
  });

  @override
  State<StatefulWidget> createState() {
    return ProjectActionItemsListViewState();
  }
}

class ProjectActionItemsListViewState
    extends State<ProjectActionItemsListView> {
  Set<ActionItem> selectedItems = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.shadow,
      child: widget.actionItems.isEmpty
          ? Center(
              child: Padding(
              padding: const EdgeInsets.all(Constants.paddingSmall),
              child: Text("You haven't made a plan yet 💀",
                  style: Theme.of(context).textTheme.labelLarge),
            ))
          : Column(
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: widget.actionItems.length,
                  itemBuilder: (context, index) {
                    final actionItem = widget.actionItems[index];
                    return ProjectActionItemView(
                      actionItem: actionItem,
                      onActionItemEdited: (String newText) {
                        widget.onActionItemEdited(actionItem, newText);
                      },
                      onActionItemChecked: (bool isChecked) {
                        widget.onActionItemChecked(actionItem, isChecked);
                      },
                      onActionItemSelected: (bool isSelected) {
                        if (isSelected) {
                          HapticFeedback.vibrate();
                        }
                        widget.selectionController
                            .setActionItemSelected(actionItem, isSelected);
                        setState(() {});
                      },
                      onDeadlinePressed: () {
                        widget.onDeadlinePressed?.call(actionItem);
                      },
                      isSelected: widget.selectionState.selectedItems
                          .contains(actionItem),
                      isSelectionMode: widget.selectionState.isSelectionMode,
                    );
                  },
                ),
              ],
            ),
    );
  }
}
