import 'package:droomy/data/models/workflow_step.dart';
import 'package:flutter/material.dart';

import '../../../../../data/models/project.dart';
import '../../../../../data/models/workflow.dart';

class DashboardOverviewProjectsListView extends StatelessWidget {
  final List<Project> projects;
  final void Function(Project project)? onProjectSelected; // List of projects

  const DashboardOverviewProjectsListView(
      {super.key, required this.projects, this.onProjectSelected});

  @override
  Widget build(BuildContext context) {
    if (projects.isEmpty) {
      return const Center(child: Text('You have no active projects'));
    }

    return ListView.builder(
      itemBuilder: _getItemWidget,
      itemCount: projects.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }

  Widget _getItemWidget(BuildContext context, int index) {
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
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
            child: Hero(
              tag: "project_title_${project.projectId}",
              child: Text(project.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall),
            ),
          )),
          subtitle: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text(currentStep?.displayName ?? 'IN PROGRESS')),
                const SizedBox(height: 8),
                progressBar,
              ],
            ),
          ),
          onTap: () {
            onProjectSelected?.call(project);
          },
        ),
      ),
    );
  }
}
