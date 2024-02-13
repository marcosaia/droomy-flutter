import 'package:droomy/common/constants.dart';
import 'package:droomy/common/utils.dart';
import 'package:droomy/data/models/project.dart';
import 'package:droomy/screens/base/view_state.dart';
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
  List<Project> _readyReleases = [];
  List<Project> _scheduledReleases = [];

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

    // Filter Ready Releases
    _readyReleases = state.releases
        .where((release) => release.plannedReleaseDate == null)
        .toList();

    // Filter and sort Scheduled Releases
    _scheduledReleases = state.releases
        .where((release) => release.plannedReleaseDate != null)
        .toList();
    _scheduledReleases.sort((pr1, pr2) =>
        pr1.plannedReleaseDate!.isBefore(pr2.plannedReleaseDate!) ? -1 : 1);

    return SingleChildScrollView(
      child: Container(
          margin:
              const EdgeInsets.symmetric(horizontal: Constants.paddingRegular),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ..._readyToReleaseSection,
                ..._scheduledReleasesSection,
              ])),
    );
  }

  List<Widget> _getReleasesSection({
    required String title,
    required Icon icon,
    required void Function() onFilterTap,
    required String subheaderText,
    required List<Project> projects,
    required void Function(Project project) onProjectSelected,
  }) {
    final state = ref.watch(dashboardReleasesControllerProvider);
    return [
      const SizedBox(
        height: Constants.paddingRegular,
      ),
      Row(
        children: [
          Row(children: [
            Text(title, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(width: Constants.paddingSmall),
            icon,
          ]),
          const Spacer(),
          GestureDetector(onTap: onFilterTap, child: const Icon(Icons.sort)),
        ],
      ),
      Visibility(
          visible: state.viewState != const ViewStateLoading(),
          child: Column(
            children: [
              const SizedBox(height: Constants.paddingRegular),
              Text(subheaderText),
            ],
          )),
      const SizedBox(height: Constants.paddingRegular),
      state.viewState.map(loaded: (_) {
        return DashboardReleasesListView(
          releases: projects,
          onReleaseSelected: onProjectSelected,
        );
      }, loading: (_) {
        return const Center(child: CircularProgressIndicator());
      }, error: (_) {
        return Container();
      })
    ];
  }

  List<Widget> get _readyToReleaseSection {
    return _getReleasesSection(
      title: "Ready to release",
      icon: const Icon(Icons.rocket_launch),
      onFilterTap: () => showMessageOverlay(context, message: 'Filter pressed'),
      subheaderText: _readySubheaderText,
      projects: _readyReleases,
      onProjectSelected: (project) {
        _navigateToReleaseDetail(project);
      },
    );
  }

  List<Widget> get _scheduledReleasesSection {
    return _getReleasesSection(
      title: "Scheduled releases",
      icon: const Icon(Icons.schedule),
      onFilterTap: () => showMessageOverlay(context, message: 'Filter pressed'),
      subheaderText: _scheduledSubheaderText,
      projects: _scheduledReleases,
      onProjectSelected: (project) {
        // _navigateToReleaseDetail(project);
      },
    );
  }

  Future<void> _navigateToReleaseDetail(Project project) async {
    Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
      return ReleaseDetailScreen(project: project);
    }));
  }

  String get _readySubheaderText {
    if (_readyReleases.isEmpty) {
      return "You don't have any releases yet. Start by creating a new song in the overview page.";
    } else {
      final isOne = _readyReleases.length == 1;
      return "Let's go! You have ${_readyReleases.length} song${isOne ? '' : 's'} that ${isOne ? 'is' : 'are'} ready to be published!";
    }
  }

  String get _scheduledSubheaderText {
    if (_scheduledReleases.isEmpty) {
      return "You don't have any scheduled releases yet.";
    } else {
      final isOne = _scheduledReleases.length == 1;
      return "Congrats! 💪 You have ${_scheduledReleases.length} scheduled release${isOne ? '' : 's'}!";
    }
  }
}
