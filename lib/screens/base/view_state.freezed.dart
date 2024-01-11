// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ViewState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() error,
    required TResult Function() loading,
    required TResult Function() loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? error,
    TResult? Function()? loading,
    TResult? Function()? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? error,
    TResult Function()? loading,
    TResult Function()? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ViewStateError value) error,
    required TResult Function(ViewStateLoading value) loading,
    required TResult Function(ViewStateLoaded value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ViewStateError value)? error,
    TResult? Function(ViewStateLoading value)? loading,
    TResult? Function(ViewStateLoaded value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ViewStateError value)? error,
    TResult Function(ViewStateLoading value)? loading,
    TResult Function(ViewStateLoaded value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ViewStateCopyWith<$Res> {
  factory $ViewStateCopyWith(ViewState value, $Res Function(ViewState) then) =
      _$ViewStateCopyWithImpl<$Res, ViewState>;
}

/// @nodoc
class _$ViewStateCopyWithImpl<$Res, $Val extends ViewState>
    implements $ViewStateCopyWith<$Res> {
  _$ViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ViewStateErrorImplCopyWith<$Res> {
  factory _$$ViewStateErrorImplCopyWith(_$ViewStateErrorImpl value,
          $Res Function(_$ViewStateErrorImpl) then) =
      __$$ViewStateErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ViewStateErrorImplCopyWithImpl<$Res>
    extends _$ViewStateCopyWithImpl<$Res, _$ViewStateErrorImpl>
    implements _$$ViewStateErrorImplCopyWith<$Res> {
  __$$ViewStateErrorImplCopyWithImpl(
      _$ViewStateErrorImpl _value, $Res Function(_$ViewStateErrorImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ViewStateErrorImpl implements ViewStateError {
  const _$ViewStateErrorImpl();

  @override
  String toString() {
    return 'ViewState.error()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ViewStateErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() error,
    required TResult Function() loading,
    required TResult Function() loaded,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? error,
    TResult? Function()? loading,
    TResult? Function()? loaded,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? error,
    TResult Function()? loading,
    TResult Function()? loaded,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ViewStateError value) error,
    required TResult Function(ViewStateLoading value) loading,
    required TResult Function(ViewStateLoaded value) loaded,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ViewStateError value)? error,
    TResult? Function(ViewStateLoading value)? loading,
    TResult? Function(ViewStateLoaded value)? loaded,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ViewStateError value)? error,
    TResult Function(ViewStateLoading value)? loading,
    TResult Function(ViewStateLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ViewStateError implements ViewState {
  const factory ViewStateError() = _$ViewStateErrorImpl;
}

/// @nodoc
abstract class _$$ViewStateLoadingImplCopyWith<$Res> {
  factory _$$ViewStateLoadingImplCopyWith(_$ViewStateLoadingImpl value,
          $Res Function(_$ViewStateLoadingImpl) then) =
      __$$ViewStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ViewStateLoadingImplCopyWithImpl<$Res>
    extends _$ViewStateCopyWithImpl<$Res, _$ViewStateLoadingImpl>
    implements _$$ViewStateLoadingImplCopyWith<$Res> {
  __$$ViewStateLoadingImplCopyWithImpl(_$ViewStateLoadingImpl _value,
      $Res Function(_$ViewStateLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ViewStateLoadingImpl implements ViewStateLoading {
  const _$ViewStateLoadingImpl();

  @override
  String toString() {
    return 'ViewState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ViewStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() error,
    required TResult Function() loading,
    required TResult Function() loaded,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? error,
    TResult? Function()? loading,
    TResult? Function()? loaded,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? error,
    TResult Function()? loading,
    TResult Function()? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ViewStateError value) error,
    required TResult Function(ViewStateLoading value) loading,
    required TResult Function(ViewStateLoaded value) loaded,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ViewStateError value)? error,
    TResult? Function(ViewStateLoading value)? loading,
    TResult? Function(ViewStateLoaded value)? loaded,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ViewStateError value)? error,
    TResult Function(ViewStateLoading value)? loading,
    TResult Function(ViewStateLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ViewStateLoading implements ViewState {
  const factory ViewStateLoading() = _$ViewStateLoadingImpl;
}

/// @nodoc
abstract class _$$ViewStateLoadedImplCopyWith<$Res> {
  factory _$$ViewStateLoadedImplCopyWith(_$ViewStateLoadedImpl value,
          $Res Function(_$ViewStateLoadedImpl) then) =
      __$$ViewStateLoadedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ViewStateLoadedImplCopyWithImpl<$Res>
    extends _$ViewStateCopyWithImpl<$Res, _$ViewStateLoadedImpl>
    implements _$$ViewStateLoadedImplCopyWith<$Res> {
  __$$ViewStateLoadedImplCopyWithImpl(
      _$ViewStateLoadedImpl _value, $Res Function(_$ViewStateLoadedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ViewStateLoadedImpl implements ViewStateLoaded {
  const _$ViewStateLoadedImpl();

  @override
  String toString() {
    return 'ViewState.loaded()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ViewStateLoadedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() error,
    required TResult Function() loading,
    required TResult Function() loaded,
  }) {
    return loaded();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? error,
    TResult? Function()? loading,
    TResult? Function()? loaded,
  }) {
    return loaded?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? error,
    TResult Function()? loading,
    TResult Function()? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ViewStateError value) error,
    required TResult Function(ViewStateLoading value) loading,
    required TResult Function(ViewStateLoaded value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ViewStateError value)? error,
    TResult? Function(ViewStateLoading value)? loading,
    TResult? Function(ViewStateLoaded value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ViewStateError value)? error,
    TResult Function(ViewStateLoading value)? loading,
    TResult Function(ViewStateLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class ViewStateLoaded implements ViewState {
  const factory ViewStateLoaded() = _$ViewStateLoadedImpl;
}
