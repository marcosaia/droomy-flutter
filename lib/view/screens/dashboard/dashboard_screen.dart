import 'package:droomy/service/projects/project_repository_provider.dart';
import 'package:droomy/widget/projects_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/user.dart';
import '../../../service/authentication/auth_service_provider.dart';
import '../../../widget/progress_overview_card.dart';
import '../../widgets/user_profile_app_bar.dart';
import 'widgets/dashboard_header.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _DashboardScreenState();
  }
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    User? currentUser = ref.watch(authProvider).currentUser;
    // TODO: If currentUser is not available, show an error
    if (currentUser == null) {
      return const Scaffold();
    }

    var projects = ref.watch(projectsProvider);

    return Scaffold(
      appBar: UserProfileAppBar(currentUser: currentUser),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 32.0),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DashboardHeader(currentUser: currentUser),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
              ),
              const ProgressOverviewCard(),
              const SizedBox(height: 16),
              Text('Your projects',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 16),
              ProjectsListView(projects)
            ],
          ),
        ),
      ),
    );
  }
}
