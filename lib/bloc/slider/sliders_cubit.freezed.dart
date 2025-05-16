// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sliders_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SlidersState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlidersState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SlidersState()';
}


}

/// @nodoc
class $SlidersStateCopyWith<$Res>  {
$SlidersStateCopyWith(SlidersState _, $Res Function(SlidersState) __);
}


/// @nodoc


class SliderInitial implements SlidersState {
  const SliderInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SliderInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SlidersState.initial()';
}


}




/// @nodoc


class SliderLoading implements SlidersState {
  const SliderLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SliderLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SlidersState.loading()';
}


}




/// @nodoc


class SliderLoaded implements SlidersState {
  const SliderLoaded(final  List<SliderModel> sliders): _sliders = sliders;
  

 final  List<SliderModel> _sliders;
 List<SliderModel> get sliders {
  if (_sliders is EqualUnmodifiableListView) return _sliders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sliders);
}


/// Create a copy of SlidersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SliderLoadedCopyWith<SliderLoaded> get copyWith => _$SliderLoadedCopyWithImpl<SliderLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SliderLoaded&&const DeepCollectionEquality().equals(other._sliders, _sliders));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_sliders));

@override
String toString() {
  return 'SlidersState.loaded(sliders: $sliders)';
}


}

/// @nodoc
abstract mixin class $SliderLoadedCopyWith<$Res> implements $SlidersStateCopyWith<$Res> {
  factory $SliderLoadedCopyWith(SliderLoaded value, $Res Function(SliderLoaded) _then) = _$SliderLoadedCopyWithImpl;
@useResult
$Res call({
 List<SliderModel> sliders
});




}
/// @nodoc
class _$SliderLoadedCopyWithImpl<$Res>
    implements $SliderLoadedCopyWith<$Res> {
  _$SliderLoadedCopyWithImpl(this._self, this._then);

  final SliderLoaded _self;
  final $Res Function(SliderLoaded) _then;

/// Create a copy of SlidersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sliders = null,}) {
  return _then(SliderLoaded(
null == sliders ? _self._sliders : sliders // ignore: cast_nullable_to_non_nullable
as List<SliderModel>,
  ));
}


}

/// @nodoc


class SliderError implements SlidersState {
  const SliderError(this.message);
  

 final  String message;

/// Create a copy of SlidersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SliderErrorCopyWith<SliderError> get copyWith => _$SliderErrorCopyWithImpl<SliderError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SliderError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SlidersState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $SliderErrorCopyWith<$Res> implements $SlidersStateCopyWith<$Res> {
  factory $SliderErrorCopyWith(SliderError value, $Res Function(SliderError) _then) = _$SliderErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SliderErrorCopyWithImpl<$Res>
    implements $SliderErrorCopyWith<$Res> {
  _$SliderErrorCopyWithImpl(this._self, this._then);

  final SliderError _self;
  final $Res Function(SliderError) _then;

/// Create a copy of SlidersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SliderError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
