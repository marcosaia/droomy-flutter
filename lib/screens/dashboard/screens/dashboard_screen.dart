import 'package:droomy/common/constants.dart';
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
        body: state.isProjectsLoading
            ? const Center(child: CircularProgressIndicator())
            : _ProjectsList(
                title: 'Your projects',
                currentUser: currentUser,
                projects: state.projects,
                onProjectSelected: (project) {
                  _navigateToProjectDetail(context, project);
                },
              ));
  }

  void _navigateToProjectDetail(BuildContext context, Project project) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProjectDetailScreen(project: project)));
  }
}

class _ProjectsList extends StatelessWidget {
  const _ProjectsList({
    required this.title,
    required this.currentUser,
    required this.projects,
    required this.onProjectSelected,
  });

  final String title;
  final User currentUser;
  final List<Project> projects;
  final void Function(Project project) onProjectSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 32.0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DashboardHeader(currentUser: currentUser),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: Constants.paddingSmall),
            ),
            const UserProgressOverviewCard(),
            const SizedBox(height: 16),
            Text(title, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 16),
            ProjectsListView(
              projects: projects,
              onProjectSelected: onProjectSelected,
            )
          ],
        ),
      ),
    );
  }
}
