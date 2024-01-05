import 'package:droomy/service/projects/base/project_repository.dart';
import 'package:droomy/service/projects/firebase_project_repository.dart';
import 'package:riverpod/riverpod.dart';

final projectRepositoryProvider =
    Provider<ProjectRepository>((ref) => FirebaseProjectRepository());
