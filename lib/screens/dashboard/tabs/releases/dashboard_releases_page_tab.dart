import 'package:droomy/common/constants.dart';
import 'package:droomy/common/utils.dart';
import 'package:droomy/data/models/project.dart';
import 'package:droomy/screens/dashboard/tabs/releases/controllers/dashboard_releases_controller.dart';
import 'package:droomy/screens/dashboard/tabs/releases/widgets/dashboard_releases_list_view.dart';
import 'package:droomy/screens/release/screens/release_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardReleasesPageTab extends ConsumerStatefulWidget {
  const DashboardReleasesPageTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _DashboardReleasesPageTabState();
  }
}

class _DashboardReleasesPageTabState
    extends ConsumerState<DashboardReleasesPageTab> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = ref.read(dashboardReleasesControllerProvider.notifier);
      controller.fetchReleases();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardReleasesControllerProvider);

    return SingleChildScrollView(
      child: Container(
          margin:
              const EdgeInsets.symmetric(horizontal: Constants.paddingRegular),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: Constants.paddingRegular,
                ),
                Row(
                  children: [
                    Row(children: [
                      Text('Ready to release',
                          style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(width: Constants.paddingSmall),
                      const Icon(Icons.rocket_launch)
                    ]),
                    const Spacer(),
                    GestureDetector(
                        onTap: () => showMessageOverlay(context,
                            message: 'Filter pressed'),
                        child: const Icon(Icons.sort)),
                  ],
                ),
                const SizedBox(height: Constants.paddingRegular),
                Text(_subheaderText),
                const SizedBox(height: Constants.paddingRegular),
                state.viewState.map(loaded: (_) {
                  return DashboardReleasesListView(
                    releases: state.releases,
                    onReleaseSelected: (project) {
                      _navigateToReleaseDetail(project);
                    },
                  );
                }, loading: (_) {
                  return const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }, error: (_) {
                  return Container();
                })
              ])),
    );
  }

  Future<void> _navigateToReleaseDetail(Project project) async {
    Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
      return ReleaseDetailScreen(project: project);
    }));
  }

  String get _subheaderText {
    final state = ref.read(dashboardReleasesControllerProvider);
    if (state.releases.isEmpty) {
      return "You don't have any releases yet. Start by creating a new song in the overview page.";
    } else {
      final isOne = state.releases.length == 1;
      return "Let's go! You have ${state.releases.length} song${isOne ? '' : 's'} that ${isOne ? 'is' : 'are'} ready to be published!";
    }
  }
}
