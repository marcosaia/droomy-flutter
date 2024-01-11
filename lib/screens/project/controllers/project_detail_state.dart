import 'package:droomy/models/project.dart';
import 'package:droomy/screens/base/view_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_detail_state.freezed.dart';

@freezed
class ProjectDetailState with _$ProjectDetailState {
  factory ProjectDetailState({
    required Project? project,
    required ViewState viewState,
  }) = _ProjectDetailState;

  static ProjectDetailState defaultState() =>
      ProjectDetailState(project: null, viewState: const ViewStateLoaded());
}
