import 'package:droomy/common/constants.dart';
import 'package:droomy/models/project.dart';
import 'package:flutter/material.dart';

class ProjectDetailHeaderView extends StatelessWidget {
  final Project project;

  const ProjectDetailHeaderView({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    // Calculate current workflow progress
    var progress = 0.0;
    final workflow = project.workflow;
    if (workflow != null) {
      progress = (workflow.currentStepIndex + 1) / workflow.steps.length;
    }

    return Container(
      color: Theme.of(context).colorScheme.shadow,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: "project_title_${project.projectId}",
                      child: Text(
                        project.title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Constants.paddingSmall),
                Text(
                  project.workflow?.currentStep?.displayName ?? "-",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                const SizedBox(height: Constants.paddingRegular),
                LinearProgressIndicator(
                  value: progress,
                ),
                const SizedBox(height: Constants.paddingRegular),
                Text(project.workflow?.currentStep?.shortDescription ?? "-"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
