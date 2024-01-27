import 'package:audioplayers/audioplayers.dart';
import 'package:droomy/common/constants.dart';
import 'package:droomy/models/action_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ProjectActionItemView extends StatefulWidget {
  final ActionItem actionItem;
  final void Function(String newText) onActionItemEdited;
  final void Function(bool isChecked) onActionItemChecked;
  final void Function(bool isSelected) onActionItemSelected;
  final bool isSelectionMode;
  final bool isSelected;

  const ProjectActionItemView(
      {super.key,
      required this.actionItem,
      required this.isSelected,
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
  bool _isTextFieldEnabled = false;

  @override
  void initState() {
    _textEditingController.text = widget.actionItem.shortDescription;
    _isChecked = widget.actionItem.isCompleted;

    // Add a listener to the focus node to track when the keyboard is dismissed
    _configureTextFocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _originalText = widget.actionItem.shortDescription;

    if (!_isTextFieldEnabled) {
      _textEditingController.text = widget.actionItem.shortDescription;
    }

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: widget.isSelected
              ? Constants.paddingRegular
              : Constants.paddingSmall,
          horizontal: widget.isSelected ? Constants.paddingRegular : 0.0),
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
                color: widget.isSelected
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
                    : Theme.of(context).colorScheme.background,
                border: _getBorder(context),
                borderRadius: const BorderRadius.all(Radius.circular(16.0))),
            child: Shimmer(
              duration: const Duration(seconds: kAnimationDuration),
              enabled: _shouldAnimate || widget.isSelected,
              color: Theme.of(context).colorScheme.primary,
              colorOpacity: 0.3,
              interval: const Duration(seconds: kAnimationDuration),
              child: ListTile(
                  selected: widget.isSelected,
                  title: Form(
                    key: _formKey,
                    child: GestureDetector(
                      onTap: () {
                        if (widget.isSelectionMode) {
                          _toggleSelection();
                        } else {
                          if (!_isChecked && !widget.isSelected) {
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
                                  widget.isSelected ||
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
                    ignoring: widget.isSelected,
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

  // UI Utility Methods
  void _configureTextFocusNode() {
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
  }

  // Sounds & Animation Utility Methods
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

  _toggleSelection() {
    setState(() {
      widget.onActionItemSelected(!widget.isSelected);
    });
  }

  _textFieldTheme() {
    return Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontSize: _isChecked ? 20.0 : null,
        decoration: _isChecked ? TextDecoration.none : TextDecoration.none);
  }

  BoxBorder? _getBorder(BuildContext context) {
    if (widget.isSelected) {
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
}