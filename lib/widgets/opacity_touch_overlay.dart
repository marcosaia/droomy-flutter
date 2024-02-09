import 'package:flutter/material.dart';

/// A Widget which covers the full available width and height and listens for
/// touches. The opacity the widget has when it is visible can be configured.
class OpacityTouchOverlay extends StatefulWidget {
  final bool isOverlayVisible;
  final double opacity;
  final void Function() onOverlayTouched;

  const OpacityTouchOverlay(
      {super.key,
      required this.isOverlayVisible,
      required this.onOverlayTouched,
      this.opacity = 0.9});

  @override
  State<OpacityTouchOverlay> createState() => _OpacityTouchOverlayState();
}

class _OpacityTouchOverlayState extends State<OpacityTouchOverlay> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.isOverlayVisible) {
          return;
        }
        widget.onOverlayTouched();
      },
      child: IgnorePointer(
        ignoring: !widget.isOverlayVisible,
        child: Opacity(
          opacity: widget.isOverlayVisible ? widget.opacity : 0,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Theme.of(context).colorScheme.background,
          ),
        ),
      ),
    );
  }
}
