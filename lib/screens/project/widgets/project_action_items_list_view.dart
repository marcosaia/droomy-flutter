import 'package:audioplayers/audioplayers.dart';
import 'package:droomy/common/constants.dart';
import 'package:droomy/models/action_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ProjectActionItemsListView extends StatefulWidget {
  final List<ActionItem> actionItems;
  final void Function(ActionItem actionItem, String newText) onActionItemEdited;
  final void Function(Set<ActionItem> selectedItems) onActionItemSelected;
  final void Function(ActionItem actionItem, bool isChecked)
      onActionItemChecked;

  const ProjectActionItemsListView({
    super.key,
    required this.actionItems,
    required this.onActionItemEdited,
    required this.onActionItemSelected,
    required this.onActionItemChecked,
  });

  @override
  State<StatefulWidget> createState() {
    return ProjectActionItemsListViewState();
  }
}

class ProjectActionItemsListViewState
    extends State<ProjectActionItemsListView> {
  bool _isSelectionMode = false;
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
                          _isSelectionMode = true;
                          selectedItems.add(actionItem);
                        } else {
                          selectedItems.remove(actionItem);
                          if (selectedItems.isEmpty) {
                            _isSelectionMode = false;
                          }
                        }

                        widget.onActionItemSelected(selectedItems);
                        setState(() {});
                      },
                      isSelectionMode: _isSelectionMode,
                    );
                  },
                ),
              ],
            ),
    );
  }
}

class ProjectActionItemView extends StatefulWidget {
  final ActionItem actionItem;
  final void Function(String newText) onActionItemEdited;
  final void Function(bool isChecked) onActionItemChecked;
  final void Function(bool isSelected) onActionItemSelected;
  final bool isSelectionMode;

  const ProjectActionItemView(
      {super.key,
      required this.actionItem,
      required this.onActionItemEdited,
      required this.onActionItemChecked,
      required this.onActionItemSelected,
      required this.isSelectionMode});

  @override
  State<ProjectActionItemView> createState() => _ProjectActionItemViewState();
}

class _ProjectActionItemViewState extends State<ProjectActionItemView> {
  static const kAnimationDuration = 2;

  var _isChecked = false;
  final _textEditingController = TextEditingController(text: "");
  final FocusNode _focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  bool _isValid = false;
  String _originalText = '';
  bool _shouldAnimate = false;

  bool _isSelected = false;
  bool _isTextFieldEnabled = false;

  @override
  void initState() {
    _textEditingController.text = widget.actionItem.shortDescription;
    _originalText = widget.actionItem.shortDescription;
    _isChecked = widget.actionItem.isCompleted;

    // Add a listener to the focus node to track when the keyboard is dismissed
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // If the focus is lost and the new text is valid, we update the original text
        if (_isValid) {
          final newText = _textEditingController.text.trim();
          _textEditingController.text = newText;
          if (newText != _originalText) {
            _originalText = newText;
            widget.onActionItemEdited(newText);
          }
        }
        // If the focus is lost and the text is not valid, revert to the original text
        else {
          if (_textEditingController.text != _originalText) {
            _textEditingController.text = _originalText;
          }
        }
        _isTextFieldEnabled = false;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  BoxBorder? _getBorder(BuildContext context) {
    if (_isSelected) {
      return Border.all(
        color: Theme.of(context).colorScheme.secondary,
        width: 1.0,
      );
    }

    if (_isChecked) {
      return Border.all(
        color: Theme.of(context).colorScheme.primary, // Set the border color
        width: 2.0, // Set the border width
      );
    }

    return null;
  }

  _toggleSelection() {
    setState(() {
      _isSelected = !_isSelected;
      if (_isSelected) {
        HapticFeedback.vibrate();
      }
      widget.onActionItemSelected(_isSelected);
    });
  }

  _textFieldTheme() {
    return Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontSize: _isChecked ? 20.0 : null,
        decoration: _isChecked ? TextDecoration.none : TextDecoration.none);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical:
              _isSelected ? Constants.paddingRegular : Constants.paddingSmall,
          horizontal: _isSelected ? Constants.paddingRegular : 0.0),
      child: GestureDetector(
        onTap: widget.isSelectionMode
            ? () {
                _toggleSelection();
              }
            : null,
        onLongPress: () {
          _toggleSelection();
        },
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(
                vertical: _isChecked ? 0 : 8.0, horizontal: 0.0),
            decoration: BoxDecoration(
                color: _isSelected
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
                    : Theme.of(context).colorScheme.background,
                border: _getBorder(context),
                borderRadius: const BorderRadius.all(Radius.circular(16.0))),
            child: Shimmer(
              duration: const Duration(seconds: kAnimationDuration),
              enabled: _shouldAnimate || _isSelected,
              color: Theme.of(context).colorScheme.primary,
              colorOpacity: 0.3,
              interval: const Duration(seconds: kAnimationDuration),
              child: ListTile(
                  selected: _isSelected,
                  title: Form(
                    key: _formKey,
                    child: GestureDetector(
                      onTap: () {
                        if (widget.isSelectionMode) {
                          _toggleSelection();
                        } else {
                          if (!_isChecked && !_isSelected) {
                            setState(() {
                              _isTextFieldEnabled = true;
                            });
                          }
                        }
                      },
                      onLongPress: () {
                        _toggleSelection();
                      },
                      child: _isTextFieldEnabled
                          ? TextFormField(
                              autofocus: true,
                              enabled: !(_isChecked ||
                                  _isSelected ||
                                  widget.isSelectionMode),
                              controller: _textEditingController,
                              focusNode: _focusNode,
                              onEditingComplete: () {
                                if (_isValid) {
                                  final newText =
                                      _textEditingController.text.trim();
                                  _originalText = newText;
                                  widget.onActionItemEdited(newText);
                                  FocusScope.of(context).unfocus();
                                  _isTextFieldEnabled = false;
                                  setState(() {});
                                }
                              },
                              onChanged: (value) {
                                setState(() {
                                  _isValid =
                                      _formKey.currentState?.validate() ??
                                          false;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "The text shall not be empty bruh.";
                                }

                                return null;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                fillColor: Colors.transparent,
                                contentPadding: EdgeInsets.all(0),
                                errorBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                              ),
                              maxLines: null,
                              keyboardType: TextInputType.text,
                              style: _textFieldTheme(),
                            )
                          : Text(widget.actionItem.shortDescription,
                              style: _textFieldTheme()),
                    ),
                  ),
                  subtitle: _isChecked
                      ? null
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: Constants.paddingSmall),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_month, size: 16),
                              const SizedBox(width: Constants.paddingSmall),
                              Text(
                                  widget.actionItem.deadline
                                          ?.toLocal()
                                          .toString() ??
                                      "No deadline",
                                  style:
                                      Theme.of(context).textTheme.labelSmall),
                            ],
                          ),
                        ),
                  leading: IgnorePointer(
                    ignoring: _isSelected,
                    child: Checkbox(
                        value: _isChecked,
                        onChanged: (value) {
                          setState(() {
                            _isChecked = value ?? false;
                            if (_isChecked) {
                              HapticFeedback.vibrate();
                              _playBleepSound();
                              _triggerAnimation();
                            } else {
                              _playUndoSound();
                            }

                            widget.onActionItemChecked(_isChecked);
                          });
                        }),
                  )),
            )),
      ),
    );
  }

  _playBleepSound() {
    AudioPlayer().play(AssetSource('sounds/sfx_task_done_bleep.mp3'));
  }

  _playUndoSound() {
    AudioPlayer().play(AssetSource('sounds/sfx_undo_woosh.mp3'));
  }

  _triggerAnimation() {
    _shouldAnimate = true;

    Future.delayed(const Duration(seconds: kAnimationDuration), () {
      setState(() {
        _shouldAnimate = false;
      });
    });
  }

  // return Padding(
  //   padding: const EdgeInsets.symmetric(vertical: Constants.paddingSmall),
  //   child: Container(
  //       padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
  //       decoration: BoxDecoration(
  //           color: Theme.of(context).colorScheme.background,
  //           borderRadius: const BorderRadius.all(Radius.circular(16.0))),
  //       child: Container(
  //           color: Theme.of(context).colorScheme.background,
  //           child: Row(
  //             children: [
  //               Checkbox(
  //                   value: isChecked,
  //                   onChanged: (value) {
  //                     setState(() {
  //                       isChecked = value ?? false;
  //                     });
  //                   }),
  //               GestureDetector(
  //                 onTap: () {
  //                   setState(() {
  //                     isEditMode = true;
  //                   });
  //                 },
  //                 child: Column(
  //                   children: [
  //                     SizedBox(
  //                       width: 100,
  //                       child: TextField(
  //                         controller: _textEditingController,
  //                         enabled: isEditMode,
  //                         style: Theme.of(context).textTheme.bodyLarge,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               )
  //             ],
  //           ))),
  // );
  // }
}

// CheckboxListTile(
//                         contentPadding: const EdgeInsets.all(0),
//                         title: Text(actionItem.shortDescription,
//                             style: actionItem.isCompleted
//                                 ? Theme.of(context)
//                                     .textTheme
//                                     .labelLarge
//                                     ?.copyWith(
//                                         decoration: TextDecoration.lineThrough)
//                                 : null),
//                         value: actionItem.isCompleted,
//                         secondary: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             GestureDetector(
//                                 onTap: () =>
//                                     widget.onEditIconPressed?.call(actionItem),
//                                 child: const Icon(Icons.edit_outlined)),
//                             const SizedBox(
//                               width: 8.0,
//                             ),
//                             GestureDetector(
//                                 onTap: () => widget.onDeleteIconPressed
//                                     ?.call(actionItem),
//                                 child: const Icon(Icons.delete)),
//                           ],
//                         ),
//                         controlAffinity: ListTileControlAffinity.leading,
//                         enableFeedback: true,
//                         onChanged: (bool? value) {
//                           widget.onCheckboxPressed
//                               ?.call(actionItem, value ?? false);
//                         },
//                       );
