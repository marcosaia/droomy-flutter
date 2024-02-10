import 'package:droomy/common/constants.dart';
import 'package:droomy/common/utils.dart';
import 'package:droomy/data/models/project.dart';
import 'package:droomy/screens/dashboard/tabs/overview/controllers/dashboard_overview_controller.dart';
import 'package:droomy/screens/dashboard/tabs/overview/widgets/dashboard_overview_header.dart';
import 'package:droomy/screens/dashboard/tabs/overview/widgets/dashboard_overview_projects_list_view.dart';
import 'package:droomy/screens/dashboard/tabs/overview/widgets/dashboard_overview_progress_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardOverviewTab extends ConsumerStatefulWidget {
  const DashboardOverviewTab({
    super.key,
    required this.onProjectSelected,
  });

  final void Function(Project project) onProjectSelected;

  @override
  ConsumerState<DashboardOverviewTab> createState() =>
      _DashboardOverviewTabState();
}

class _DashboardOverviewTabState extends ConsumerState<DashboardOverviewTab> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(dashboardOverviewControllerProvider.notifier)
          .fetchUserProjects();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardOverviewControllerProvider);
    const padding = EdgeInsets.fromLTRB(
        0, Constants.paddingRegular, 0, Constants.paddingBig);
    return state.isProjectsLoading
        ? Padding(padding: padding, child: _mainWidget)
        : SingleChildScrollView(padding: padding, child: _mainWidget);
  }

  Widget get _mainWidget {
    final state = ref.read(dashboardOverviewControllerProvider);
    final controller = ref.read(dashboardOverviewControllerProvider.notifier);

    // Retrieve current user or exit if null
    final currentUser = state.currentUser;
    if (currentUser == null) {
      return Builder(builder: (context) {
        Navigator.of(context).pop();
        return Container();
      });
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize:
            state.isProjectsLoading ? MainAxisSize.max : MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // User Header Text
          DashboardOverviewHeader(currentUser: currentUser),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: Constants.paddingSmall),
          ),

          // User Header Overview Card
          const DashboardOverviewProgressCard(),
          const SizedBox(height: 16),

          // Projects List and Filters
          Row(
            children: [
              Text('Your songs',
                  style: Theme.of(context).textTheme.headlineMedium),
              const Spacer(),
              GestureDetector(
                  onTap: () =>
                      showMessageOverlay(context, message: 'Filter pressed'),
                  child: const Icon(Icons.sort)),
            ],
          ),
          const SizedBox(height: 16),
          state.isProjectsLoading
              ? const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              : DashboardOverviewProjectsListView(
                  projects: state.projects,
                  onProjectSelected: (project) {
                    widget.onProjectSelected(project);
                    controller.fetchUserProjects();
                  })
        ],
      ),
    );
  }
}
