import 'package:droomy/models/project.dart';
import 'package:droomy/models/user.dart';
import 'package:droomy/screens/dashboard/controllers/dashboard_controller.dart';
import 'package:droomy/screens/dashboard/controllers/dashboard_state.dart';
import 'package:droomy/screens/dashboard/tabs/dashboard_drafts_page_tab.dart';
import 'package:droomy/screens/dashboard/tabs/dashboard_projects_overview_tab.dart';
import 'package:droomy/screens/dashboard/widgets/dashboard_end_drawer.dart';
import 'package:droomy/screens/project/screens/project_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../widgets/user_profile_app_bar.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _DashboardScreenState();
  }
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  int _currentTabIndex = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dashboardControllerProvider.notifier).fetchUserProjects();
    });
    super.initState();
  }

  Widget _getCurrentTabWidget(DashboardState state, User currentUser) {
    switch (_currentTabIndex) {
      // Dashboard Overview
      case 0:
        return DashboardProjectsOverviewTab(
          currentUser: currentUser,
          isProjectsLoading: state.isProjectsLoading,
          projects: state.projects,
          onProjectSelected: (project) {
            _navigateToProjectDetail(context, project);
          },
        );
      // Drafts
      case 1:
        return const DashboardDraftsPageTab();
    }

    return Container();
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
      body: _getCurrentTabWidget(state, currentUser),
      endDrawer: const DashboardEndDrawer(),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent),
        child: BottomNavigationBar(
            selectedFontSize: 16,
            currentIndex: _currentTabIndex,
            onTap: (index) {
              setState(() {
                _currentTabIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard), label: 'Overview'),
              BottomNavigationBarItem(icon: Icon(Icons.draw), label: 'Drafts'),
            ]),
      ),
    );
  }

  void _navigateToProjectDetail(BuildContext context, Project project) async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProjectDetailScreen(project: project)));
    ref.read(dashboardControllerProvider.notifier).fetchUserProjects();
  }
}
