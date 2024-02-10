import 'package:droomy/data/models/project.dart';
import 'package:droomy/screens/dashboard/controllers/dashboard_controller.dart';
import 'package:droomy/screens/dashboard/tabs/drafts/dashboard_drafts_page_tab.dart';
import 'package:droomy/screens/dashboard/tabs/overview/dashboard_overview_tab.dart';
import 'package:droomy/screens/dashboard/tabs/overview/widgets/dashboard_overview_end_drawer.dart';
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
  // The active tab index
  int _currentTabIndex = 0;

  // The widget for the current tab
  Widget get _currentTabWidget {
    switch (_currentTabIndex) {
      // Dashboard Overview
      case 0:
        return DashboardOverviewTab(
          onProjectSelected: (project) {
            _navigateToProjectDetail(project);
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
      body: _currentTabWidget,
      endDrawer: const DashboardOverviewEndDrawer(),
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

  // Navigates to Project Detail screen
  void _navigateToProjectDetail(Project project) async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProjectDetailScreen(project: project)));
  }
}
