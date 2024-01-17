import 'package:droomy/common/constants.dart';
import 'package:droomy/models/action_item.dart';
import 'package:flutter/material.dart';

class ProjectActionItemsListView extends StatefulWidget {
  final List<ActionItem> actionItems;
  final void Function(ActionItem actionItem)? onEditIconPressed;
  final void Function(ActionItem actionItem)? onDeleteIconPressed;
  final void Function(ActionItem actionItem, bool value)? onCheckboxPressed;

  const ProjectActionItemsListView(
      {super.key,
      required this.actionItems,
      this.onEditIconPressed,
      this.onDeleteIconPressed,
      this.onCheckboxPressed});

  @override
  State<StatefulWidget> createState() {
    return ProjectActionItemsListViewState();
  }
}

class ProjectActionItemsListViewState
    extends State<ProjectActionItemsListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.shadow,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: const BorderRadius.all(Radius.circular(16.0))),
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
                      return CheckboxListTile(
                        contentPadding: const EdgeInsets.all(0),
                        title: Text(actionItem.shortDescription,
                            style: actionItem.isCompleted
                                ? Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                        decoration: TextDecoration.lineThrough)
                                : null),
                        value: actionItem.isCompleted,
                        secondary: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                                onTap: () =>
                                    widget.onEditIconPressed?.call(actionItem),
                                child: const Icon(Icons.edit_outlined)),
                            const SizedBox(
                              width: 8.0,
                            ),
                            GestureDetector(
                                onTap: () => widget.onDeleteIconPressed
                                    ?.call(actionItem),
                                child: const Icon(Icons.delete)),
                          ],
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                        enableFeedback: true,
                        onChanged: (bool? value) {
                          widget.onCheckboxPressed
                              ?.call(actionItem, value ?? false);
                        },
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
