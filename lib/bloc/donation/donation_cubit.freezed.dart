// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'donation_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DonationState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DonationState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DonationState()';
}


}

/// @nodoc
class $DonationStateCopyWith<$Res>  {
$DonationStateCopyWith(DonationState _, $Res Function(DonationState) __);
}


/// @nodoc


class DonationInitial implements DonationState {
  const DonationInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DonationInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DonationState.initial()';
}


}




/// @nodoc


class DonationLoading implements DonationState {
  const DonationLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DonationLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DonationState.loading()';
}


}




/// @nodoc


class DonationLoaded implements DonationState {
  const DonationLoaded(final  List<DonationModel> donations, {required this.hasMore}): _donations = donations;
  

 final  List<DonationModel> _donations;
 List<DonationModel> get donations {
  if (_donations is EqualUnmodifiableListView) return _donations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_donations);
}

 final  bool hasMore;

/// Create a copy of DonationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DonationLoadedCopyWith<DonationLoaded> get copyWith => _$DonationLoadedCopyWithImpl<DonationLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DonationLoaded&&const DeepCollectionEquality().equals(other._donations, _donations)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_donations),hasMore);

@override
String toString() {
  return 'DonationState.loaded(donations: $donations, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class $DonationLoadedCopyWith<$Res> implements $DonationStateCopyWith<$Res> {
  factory $DonationLoadedCopyWith(DonationLoaded value, $Res Function(DonationLoaded) _then) = _$DonationLoadedCopyWithImpl;
@useResult
$Res call({
 List<DonationModel> donations, bool hasMore
});




}
/// @nodoc
class _$DonationLoadedCopyWithImpl<$Res>
    implements $DonationLoadedCopyWith<$Res> {
  _$DonationLoadedCopyWithImpl(this._self, this._then);

  final DonationLoaded _self;
  final $Res Function(DonationLoaded) _then;

/// Create a copy of DonationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? donations = null,Object? hasMore = null,}) {
  return _then(DonationLoaded(
null == donations ? _self._donations : donations // ignore: cast_nullable_to_non_nullable
as List<DonationModel>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class DonationError implements DonationState {
  const DonationError(this.message);
  

 final  String message;

/// Create a copy of DonationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DonationErrorCopyWith<DonationError> get copyWith => _$DonationErrorCopyWithImpl<DonationError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DonationError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'DonationState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $DonationErrorCopyWith<$Res> implements $DonationStateCopyWith<$Res> {
  factory $DonationErrorCopyWith(DonationError value, $Res Function(DonationError) _then) = _$DonationErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$DonationErrorCopyWithImpl<$Res>
    implements $DonationErrorCopyWith<$Res> {
  _$DonationErrorCopyWithImpl(this._self, this._then);

  final DonationError _self;
  final $Res Function(DonationError) _then;

/// Create a copy of DonationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(DonationError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
