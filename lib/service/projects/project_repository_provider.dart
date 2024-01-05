import 'package:droomy/service/projects/base/project_repository.dart';
import 'package:droomy/service/projects/firebase_project_repository.dart';
import 'package:riverpod/riverpod.dart';

import '../../model/project.dart';

final projectRepositoryProvider =
    Provider<ProjectRepository>((ref) => FirebaseProjectRepository());

final projectsFutureProvider = FutureProvider<List<Project>>((ref) {
  return ref.watch(projectRepositoryProvider).getAll();
});

final projectsProvider = Provider<List<Project>>((ref) {
  final asyncValue = ref.watch(projectsFutureProvider);

  if (asyncValue is AsyncData<List<Project>>) {
    return asyncValue.value;
  } else {
    return []; // Or any default value if the data is not loaded yet
  }
});

