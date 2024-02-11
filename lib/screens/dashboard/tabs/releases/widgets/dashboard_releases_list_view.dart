import 'package:droomy/common/constants.dart';
import 'package:droomy/data/models/project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardReleasesListView extends ConsumerStatefulWidget {
  final List<Project> releases;
  final void Function(Project project) onReleaseSelected;

  const DashboardReleasesListView(
      {super.key, required this.releases, required this.onReleaseSelected});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _DashboardReleasesListViewState();
  }
}

class _DashboardReleasesListViewState
    extends ConsumerState<DashboardReleasesListView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Constants.paddingBig),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.releases.length,
          itemBuilder: (context, index) {
            final release = widget.releases[index];

            return GestureDetector(
              onTap: () {
                widget.onReleaseSelected(release);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Constants.paddingSmall),
                child: Card(
                  child: ListTile(
                    key: ValueKey(release.createdAt.hashCode),
                    title: Padding(
                      padding: const EdgeInsets.all(Constants.paddingRegular),
                      child: Text(release.title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold)),
                    ),
                    trailing: const Icon(Icons.arrow_circle_right),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
