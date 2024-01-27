import 'package:freezed_annotation/freezed_annotation.dart';

part 'view_state.freezed.dart';

@freezed
class ViewState with _$ViewState {
  const factory ViewState.error() = ViewStateError;
  const factory ViewState.loading() = ViewStateLoading;
  const factory ViewState.loaded() = ViewStateLoaded;
}
