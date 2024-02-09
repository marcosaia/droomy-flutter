import 'package:droomy/common/constants.dart';
import 'package:droomy/common/utils.dart';
import 'package:droomy/screens/dashboard/tabs/drafts/widgets/dashboard_drafts_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardDraftsPageTab extends ConsumerStatefulWidget {
  const DashboardDraftsPageTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _DashboardDraftsPageTabState();
  }
}

class _DashboardDraftsPageTabState
    extends ConsumerState<DashboardDraftsPageTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  Text('Your drafts',
                      style: Theme.of(context).textTheme.headlineMedium),
                  const Spacer(),
                  GestureDetector(
                      onTap: () => showMessageOverlay(context,
                          message: 'Filter pressed'),
                      child: const Icon(Icons.sort)),
                ],
              ),
              const SizedBox(height: Constants.paddingRegular),
              const DashboardDraftsListView()
            ]));
  }
}
