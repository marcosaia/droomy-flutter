import 'package:droomy/common/constants.dart';
import 'package:droomy/common/utils.dart';
import 'package:droomy/models/project.dart';
import 'package:droomy/models/user.dart';
import 'package:droomy/screens/dashboard/widgets/dashboard_header.dart';
import 'package:droomy/screens/dashboard/widgets/projects_list_view.dart';
import 'package:droomy/screens/dashboard/widgets/user_progress_overview_card.dart';
import 'package:flutter/material.dart';

class DashboardProjectsOverviewTab extends StatefulWidget {
  const DashboardProjectsOverviewTab({
    super.key,
    required this.currentUser,
    required this.projects,
    required this.onProjectSelected,
    required this.isProjectsLoading,
  });

  final User currentUser;
  final List<Project> projects;
  final bool isProjectsLoading;
  final void Function(Project project) onProjectSelected;

  @override
  State<DashboardProjectsOverviewTab> createState() =>
      _DashboardProjectsOverviewTabState();
}

class _DashboardProjectsOverviewTabState
    extends State<DashboardProjectsOverviewTab> {
  @override
  Widget build(BuildContext context) {
    return widget.isProjectsLoading
        ? Padding(
            padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 32.0),
            child: _mainContainer,
          )
        : SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 32.0),
            child: _mainContainer);
  }

  Widget get _mainContainer {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize:
            widget.isProjectsLoading ? MainAxisSize.max : MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // User Header Text
          DashboardHeader(currentUser: widget.currentUser),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: Constants.paddingSmall),
          ),

          // User Header Overview Card
          const UserProgressOverviewCard(),
          const SizedBox(height: 16),

          // Projects List and Filters
          Row(
            children: [
              Text('Your projects',
                  style: Theme.of(context).textTheme.headlineMedium),
              const Spacer(),
              GestureDetector(
                  onTap: () =>
                      showMessageOverlay(context, message: 'Filter pressed'),
                  child: const Icon(Icons.sort)),
            ],
          ),
          const SizedBox(height: 16),
          widget.isProjectsLoading
              ? const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              : ProjectsListView(
                  projects: widget.projects,
                  onProjectSelected: widget.onProjectSelected,
                )
        ],
      ),
    );
  }
}
