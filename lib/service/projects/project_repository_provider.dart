
import 'package:droomy/service/projects/base/project_repository.dart';
import 'package:droomy/service/projects/mocked_project_repository.dart';
import 'package:riverpod/riverpod.dart';

final projectRepositoryProvider = Provider<ProjectRepository>((ref) => MockedProjectRepository());

