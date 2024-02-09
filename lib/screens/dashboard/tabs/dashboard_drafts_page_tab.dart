import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardDraftsPageTab extends ConsumerWidget {
  const DashboardDraftsPageTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(alignment: Alignment.center, child: const Text("Drafts"));
  }
}
