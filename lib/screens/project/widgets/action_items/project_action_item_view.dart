import 'package:droomy/common/constants.dart';
import 'package:droomy/common/date_utils.dart';
import 'package:droomy/helpers/audio_helper.dart';
import 'package:droomy/models/action_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ProjectActionItemView extends ConsumerStatefulWidget {
  final ActionItem actionItem;
  final void Function(String newText) onActionItemEdited;
  final void Function(bool isChecked) onActionItemChecked;
  final void Function(bool isSelected) onActionItemSelected;
  final void Function()? onDeadlinePressed;
  final bool isSelectionMode;
  final bool isSelected;
  final ReorderableDragStartListener dragStartListener;

  const ProjectActionItemView({
    super.key,
    required this.actionItem,
    required this.isSelected,
    required this.onActionItemEdited,
    required this.onActionItemChecked,
    required this.onActionItemSelected,
    required this.isSelectionMode,
    required this.dragStartListener,
    this.onDeadlinePressed,
  });

  @override
  ConsumerState<ProjectActionItemView> createState() =>
      _ProjectActionItemViewState();
}

class _ProjectActionItemViewState extends ConsumerState<ProjectActionItemView> {
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
  void didUpdateWidget(covariant ProjectActionItemView oldWidget) {
    _textEditingController.text = widget.actionItem.shortDescription;
    _isChecked = widget.actionItem.isCompleted;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final audioHelper = ref.read(audioHelperProvider);
    final remainingTime = widget.actionItem.deadline?.remainingTime();
    final isImminent = remainingTime?.isImminent ?? false;

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
        // On tap, select this item if selection mode is ON
        onTap: widget.isSelectionMode
            ? () {
                _toggleSelection();
              }
            : null,

        // On long press, toggle the selection on this item
        onLongPress: () {
          _toggleSelection();
        },

        // AnimatedContainer is used for transitions between checked and unchecked
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),

            // Padding and decoration varies depending on whether the item is checked or not
            padding: EdgeInsets.symmetric(
                vertical: _isChecked ? 0 : 8.0, horizontal: 0.0),
            decoration: BoxDecoration(
                color: widget.isSelected
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
                    : Theme.of(context).colorScheme.background,
                border: _getBorder(),
                borderRadius: const BorderRadius.all(Radius.circular(16.0))),

            // Shimmer is used to trigger a "gradient animation" when necessary
            child: Shimmer(
              // Configure the animation
              duration: const Duration(seconds: kAnimationDuration),
              color: Theme.of(context).colorScheme.primary,
              colorOpacity: 0.3,
              interval: const Duration(seconds: kAnimationDuration),

              // The animation is enabled when manually triggered or auto-loops
              // when the item is selected
              enabled: _shouldAnimate || widget.isSelected,

              child: ListTile(
                  selected: widget.isSelected,

                  // Disable the drag handler when selection mode is ON
                  trailing:
                      !widget.isSelectionMode ? widget.dragStartListener : null,

                  // The title is a form, in order to make the text editable
                  title: Form(
                    key: _formKey,
                    child: GestureDetector(
                      onTap: () {
                        // On tap, select the item if selection mode is ON
                        if (widget.isSelectionMode) {
                          _toggleSelection();
                        }
                        // Otherwise make it editable, unless it is checked or selected
                        else {
                          if (!_isChecked && !widget.isSelected) {
                            setState(() {
                              _isTextFieldEnabled = true;
                            });
                          }
                        }
                      },

                      // Toggle the selection if the user taps on the title
                      onLongPress: () {
                        _toggleSelection();
                      },

                      // Switch between a TextFormField or a simple Text depending on
                      // whether the title has been made editable by a user tap
                      child: _isTextFieldEnabled
                          // TODO: Extract Text Form Field widget
                          ? TextFormField(
                              autofocus: true,
                              enabled: !(_isChecked ||
                                  widget.isSelected ||
                                  widget.isSelectionMode),
                              controller: _textEditingController,
                              focusNode: _focusNode,
                              onEditingComplete: () {
                                // Finalize the text and unfocus the text field
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

                  // When the item is checked, the subtitle is hidden
                  subtitle: !_isChecked
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: Constants.paddingSmall),
                          child: GestureDetector(
                            onTap: () {
                              widget.onDeadlinePressed?.call();
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  size: 20,
                                  color: isImminent
                                      ? Theme.of(context).colorScheme.error
                                      : null,
                                ),
                                const SizedBox(width: Constants.paddingSmall),
                                Text(remainingTime?.message ?? "No deadline",
                                    style: isImminent
                                        ? Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .error)
                                        : Theme.of(context)
                                            .textTheme
                                            .labelLarge),
                              ],
                            ),
                          ),
                        )
                      : null,

                  // Leading Checkbox, frozen when the item is selected
                  leading: IgnorePointer(
                    ignoring: widget.isSelected,
                    child: Checkbox(
                        value: _isChecked,
                        onChanged: (value) {
                          setState(() {
                            _isChecked = value ?? false;
                            if (_isChecked) {
                              HapticFeedback.vibrate();
                              audioHelper.playBleepSound();
                              _triggerAnimation();
                            } else {
                              audioHelper.playWooshSound();
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

  // Private UI Utils
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
    return Theme.of(context)
        .textTheme
        .headlineSmall
        ?.copyWith(fontSize: _isChecked ? 20.0 : null);
  }

  BoxBorder? _getBorder() {
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
