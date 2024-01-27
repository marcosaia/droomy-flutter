import 'package:droomy/common/constants.dart';
import 'package:droomy/models/workflow.dart';
import 'package:droomy/screens/project_wizard/controllers/project_wizard_controller.dart';
import 'package:droomy/screens/project_wizard/screens/project_wizard_confirmation_screen.dart';
import 'package:droomy/widgets/image_header_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/themed_html_text.dart';

class WorkflowListView extends ConsumerStatefulWidget {
  final List<Workflow> workflows;
  final void Function(Workflow workflow)? onTap;

  const WorkflowListView({super.key, required this.workflows, this.onTap});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return WorkflowListViewState();
  }
}

class WorkflowListViewState extends ConsumerState<WorkflowListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.workflows.length,
      itemBuilder: (context, index) {
        // Get Workflow Item for current index
        Workflow workflow = widget.workflows[index];

        // Return List Item for current Workflow Item
        return GestureDetector(
          onTap: () {
            widget.onTap?.call(workflow);
          },
          child: Padding(
            padding: const EdgeInsets.all(Constants.paddingRegular),
            child: ImageHeaderCard(
                imagePath: workflow.thumbnailUrl,
                text: "",
                cardHeight: 150,
                contentWidget: Padding(
                  padding: const EdgeInsets.all(Constants.paddingRegular),
                  child: _getCardContentView(workflow),
                )),
          ),
        );
      },

      // Simple Items Divider
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  }

  // List Tile Subtitle View
  Widget _getCardContentView(final Workflow workflow) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(workflow.displayName,
            style: Theme.of(context).textTheme.displaySmall),
        const SizedBox(height: Constants.paddingSmall),
        ThemedHtmlText(htmlContent: workflow.shortDescription),
        const SizedBox(height: Constants.paddingSmall),
        Text('Steps',
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: Theme.of(context).colorScheme.primary)),
        Text(
          _getStepsDisplayText(workflow),
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(color: Theme.of(context).hintColor),
        ),
      ],
    );
  }

  // Simple utility method to format the workflow steps
  String _getStepsDisplayText(final Workflow workflow) {
    return workflow.steps.map((step) => step.displayName).join(', ');
  }
}
