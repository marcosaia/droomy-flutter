import 'package:droomy/screens/base/view_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'release_detail_state.freezed.dart';

@freezed
class ReleaseDetailState with _$ReleaseDetailState {
  factory ReleaseDetailState({
    @Default(null) DateTime? bestReleaseDate,
    @Default(null) String? releaseDateExplanation,
    @Default(false) bool isScheduled,
    required ViewState viewState,
  }) = _ReleaseDetailState;

  static ReleaseDetailState defaultState() =>
      ReleaseDetailState(viewState: const ViewStateLoaded());
}
