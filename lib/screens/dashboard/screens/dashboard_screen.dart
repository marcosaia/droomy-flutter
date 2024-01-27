import 'package:droomy/common/constants.dart';
import 'package:droomy/common/utils.dart';
import 'package:droomy/models/project.dart';
import 'package:droomy/models/user.dart';
import 'package:droomy/screens/dashboard/controllers/dashboard_controller.dart';
import 'package:droomy/screens/dashboard/widgets/dashboard_end_drawer.dart';
import 'package:droomy/screens/project/screens/project_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/user_progress_overview_card.dart';
import '../widgets/projects_list_view.dart';
import '../../../widgets/user_profile_app_bar.dart';
import '../widgets/dashboard_header.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _DashboardScreenState();
  }
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dashboardControllerProvider.notifier).fetchUserProjects();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Retrieves the logged-in user
    final state = ref.watch(dashboardControllerProvider);
    final currentUser = state.currentUser;
    if (currentUser == null) {
      return Builder(builder: (context) {
        Navigator.of(context).pop();
        return Container();
      });
    }

    return Scaffold(
        appBar: UserProfileAppBar(
          currentUser: currentUser,
          onUserProfilePressed: (BuildContext context) {
            Scaffold.of(context).openEndDrawer();
          },
        ),
        endDrawer: const DashboardEndDrawer(),
        body: _DashboardProjectsOverview(
          currentUser: currentUser,
          isProjectsLoading: state.isProjectsLoading,
          projects: state.projects,
          onProjectSelected: (project) {
            _navigateToProjectDetail(context, project);
          },
        ));
  }

  void _navigateToProjectDetail(BuildContext context, Project project) async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProjectDetailScreen(project: project)));
    ref.read(dashboardControllerProvider.notifier).fetchUserProjects();
  }
}

class _DashboardProjectsOverview extends StatefulWidget {
  const _DashboardProjectsOverview({
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
  State<_DashboardProjectsOverview> createState() =>
      _DashboardProjectsOverviewState();
}

class _DashboardProjectsOverviewState
    extends State<_DashboardProjectsOverview> {
  @override
  Widget build(BuildContext context) {
    return widget.isProjectsLoading
        ? Padding(
            padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 32.0),
            child: _getMainContainer(),
          )
        : SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 32.0),
            child: _getMainContainer());
  }

  Widget _getMainContainer() {
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
