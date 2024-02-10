import 'package:droomy/data/models/project.dart';
import 'package:droomy/services/authentication/auth_service_provider.dart';
import 'package:droomy/services/projects/base/project_repository.dart';
import 'package:droomy/services/projects/firebase_project_repository.dart';
import 'package:riverpod/riverpod.dart';

final projectRepositoryProvider = Provider<ProjectRepository>(
    (ref) => FirebaseProjectRepository(ref.watch(authServiceProvider)));

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
