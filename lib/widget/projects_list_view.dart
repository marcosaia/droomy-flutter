import 'package:flutter/material.dart';

import '../model/project.dart';
import '../model/workflow.dart';
import '../model/workflow_step.dart';

class ProjectsListView extends StatelessWidget {
  final List<Project> projects; // List of projects

  const ProjectsListView(this.projects, {super.key});

  @override
  Widget build(BuildContext context) {
    if (projects.isEmpty) {
      return const Center(child: Text('You have no active projects'));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final Project project = projects[index];
        final Workflow? workflow = project.workflow;

        WorkflowStep? currentStep;
        double? progress;
        if (workflow != null) {
          currentStep = workflow.steps[workflow.currentStepIndex];
          progress = (workflow.currentStepIndex + 1) / workflow.steps.length;
        }

        var progressBar = progress != null
            ? Column(children: [
                const SizedBox(height: 8),
                LinearProgressIndicator(value: progress)
              ])
            : const SizedBox();

        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Card(
            // Set the shape of the card using a rounded rectangle border with a 8 pixel radius
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            // Set the clip behavior of the card
            clipBehavior: Clip.antiAliasWithSaveLayer,

            child: ListTile(
              title: Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(project.title,
                    style: Theme.of(context).textTheme.headlineSmall),
              )),
              subtitle: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Text(currentStep?.displayName ?? 'IN PROGRESS')),
                    const SizedBox(height: 8),
                    progressBar,
                  ],
                ),
              ),
              onTap: () {
                // Implement any action when a project item is tapped
                // For example, navigate to a detailed view
              },
            ),
          ),
        );
      },
    );
  }
}
