import 'package:droomy/common/constants.dart';
import 'package:droomy/widgets/action_button.dart';
import 'package:flutter/material.dart';

class ActionsFloatingButton extends StatefulWidget {
  final List<ActionButton> actionButtons;
  final bool isActionsPanelVisible;
  final void Function() onFloatingButtonTap;

  const ActionsFloatingButton(
      {super.key,
      required this.actionButtons,
      required this.isActionsPanelVisible,
      required this.onFloatingButtonTap});

  @override
  State<ActionsFloatingButton> createState() => _ActionsFloatingButtonState();
}

class _ActionsFloatingButtonState extends State<ActionsFloatingButton> {
  List<Widget> get _actionItemWidgets {
    var widgets = widget.actionButtons
        .map((e) => [e, const SizedBox(height: Constants.paddingRegular)])
        .expand((l) => l)
        .toList();

    widgets[widgets.length - 1] = const SizedBox(height: Constants.paddingBig);

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Constants.paddingSmall),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IgnorePointer(
            ignoring: !widget.isActionsPanelVisible,
            child: Opacity(
              opacity: widget.isActionsPanelVisible ? 1 : 0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: _actionItemWidgets),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                widget.onFloatingButtonTap();
              });
            },
            child: widget.isActionsPanelVisible
                ? const Icon(Icons.close)
                : const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
