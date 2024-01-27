// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_action_items_selection_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ProjectActionItemsSelectionState {
  Set<ActionItem> get selectedItems => throw _privateConstructorUsedError;
  bool get isSelectionMode => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProjectActionItemsSelectionStateCopyWith<ProjectActionItemsSelectionState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectActionItemsSelectionStateCopyWith<$Res> {
  factory $ProjectActionItemsSelectionStateCopyWith(
          ProjectActionItemsSelectionState value,
          $Res Function(ProjectActionItemsSelectionState) then) =
      _$ProjectActionItemsSelectionStateCopyWithImpl<$Res,
          ProjectActionItemsSelectionState>;
  @useResult
  $Res call({Set<ActionItem> selectedItems, bool isSelectionMode});
}

/// @nodoc
class _$ProjectActionItemsSelectionStateCopyWithImpl<$Res,
        $Val extends ProjectActionItemsSelectionState>
    implements $ProjectActionItemsSelectionStateCopyWith<$Res> {
  _$ProjectActionItemsSelectionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedItems = null,
    Object? isSelectionMode = null,
  }) {
    return _then(_value.copyWith(
      selectedItems: null == selectedItems
          ? _value.selectedItems
          : selectedItems // ignore: cast_nullable_to_non_nullable
              as Set<ActionItem>,
      isSelectionMode: null == isSelectionMode
          ? _value.isSelectionMode
          : isSelectionMode // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProjectActionItemsSelectionStateImplCopyWith<$Res>
    implements $ProjectActionItemsSelectionStateCopyWith<$Res> {
  factory _$$ProjectActionItemsSelectionStateImplCopyWith(
          _$ProjectActionItemsSelectionStateImpl value,
          $Res Function(_$ProjectActionItemsSelectionStateImpl) then) =
      __$$ProjectActionItemsSelectionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Set<ActionItem> selectedItems, bool isSelectionMode});
}

/// @nodoc
class __$$ProjectActionItemsSelectionStateImplCopyWithImpl<$Res>
    extends _$ProjectActionItemsSelectionStateCopyWithImpl<$Res,
        _$ProjectActionItemsSelectionStateImpl>
    implements _$$ProjectActionItemsSelectionStateImplCopyWith<$Res> {
  __$$ProjectActionItemsSelectionStateImplCopyWithImpl(
      _$ProjectActionItemsSelectionStateImpl _value,
      $Res Function(_$ProjectActionItemsSelectionStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedItems = null,
    Object? isSelectionMode = null,
  }) {
    return _then(_$ProjectActionItemsSelectionStateImpl(
      selectedItems: null == selectedItems
          ? _value._selectedItems
          : selectedItems // ignore: cast_nullable_to_non_nullable
              as Set<ActionItem>,
      isSelectionMode: null == isSelectionMode
          ? _value.isSelectionMode
          : isSelectionMode // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ProjectActionItemsSelectionStateImpl
    implements _ProjectActionItemsSelectionState {
  _$ProjectActionItemsSelectionStateImpl(
      {required final Set<ActionItem> selectedItems,
      required this.isSelectionMode})
      : _selectedItems = selectedItems;

  final Set<ActionItem> _selectedItems;
  @override
  Set<ActionItem> get selectedItems {
    if (_selectedItems is EqualUnmodifiableSetView) return _selectedItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_selectedItems);
  }

  @override
  final bool isSelectionMode;

  @override
  String toString() {
    return 'ProjectActionItemsSelectionState(selectedItems: $selectedItems, isSelectionMode: $isSelectionMode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectActionItemsSelectionStateImpl &&
            const DeepCollectionEquality()
                .equals(other._selectedItems, _selectedItems) &&
            (identical(other.isSelectionMode, isSelectionMode) ||
                other.isSelectionMode == isSelectionMode));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_selectedItems), isSelectionMode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectActionItemsSelectionStateImplCopyWith<
          _$ProjectActionItemsSelectionStateImpl>
      get copyWith => __$$ProjectActionItemsSelectionStateImplCopyWithImpl<
          _$ProjectActionItemsSelectionStateImpl>(this, _$identity);
}

abstract class _ProjectActionItemsSelectionState
    implements ProjectActionItemsSelectionState {
  factory _ProjectActionItemsSelectionState(
          {required final Set<ActionItem> selectedItems,
          required final bool isSelectionMode}) =
      _$ProjectActionItemsSelectionStateImpl;

  @override
  Set<ActionItem> get selectedItems;
  @override
  bool get isSelectionMode;
  @override
  @JsonKey(ignore: true)
  _$$ProjectActionItemsSelectionStateImplCopyWith<
          _$ProjectActionItemsSelectionStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
