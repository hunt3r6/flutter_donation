// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campaign_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CampaignState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampaignState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CampaignState()';
}


}

/// @nodoc
class $CampaignStateCopyWith<$Res>  {
$CampaignStateCopyWith(CampaignState _, $Res Function(CampaignState) __);
}


/// @nodoc


class CampaignInitial implements CampaignState {
  const CampaignInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampaignInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CampaignState.initial()';
}


}




/// @nodoc


class CampaignLoading implements CampaignState {
  const CampaignLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampaignLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CampaignState.loading()';
}


}




/// @nodoc


class CampaignLoaded implements CampaignState {
  const CampaignLoaded(final  List<CampaignModel> campaigns): _campaigns = campaigns;
  

 final  List<CampaignModel> _campaigns;
 List<CampaignModel> get campaigns {
  if (_campaigns is EqualUnmodifiableListView) return _campaigns;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_campaigns);
}


/// Create a copy of CampaignState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampaignLoadedCopyWith<CampaignLoaded> get copyWith => _$CampaignLoadedCopyWithImpl<CampaignLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampaignLoaded&&const DeepCollectionEquality().equals(other._campaigns, _campaigns));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_campaigns));

@override
String toString() {
  return 'CampaignState.loaded(campaigns: $campaigns)';
}


}

/// @nodoc
abstract mixin class $CampaignLoadedCopyWith<$Res> implements $CampaignStateCopyWith<$Res> {
  factory $CampaignLoadedCopyWith(CampaignLoaded value, $Res Function(CampaignLoaded) _then) = _$CampaignLoadedCopyWithImpl;
@useResult
$Res call({
 List<CampaignModel> campaigns
});




}
/// @nodoc
class _$CampaignLoadedCopyWithImpl<$Res>
    implements $CampaignLoadedCopyWith<$Res> {
  _$CampaignLoadedCopyWithImpl(this._self, this._then);

  final CampaignLoaded _self;
  final $Res Function(CampaignLoaded) _then;

/// Create a copy of CampaignState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? campaigns = null,}) {
  return _then(CampaignLoaded(
null == campaigns ? _self._campaigns : campaigns // ignore: cast_nullable_to_non_nullable
as List<CampaignModel>,
  ));
}


}

/// @nodoc


class CampaignError implements CampaignState {
  const CampaignError(this.message);
  

 final  String message;

/// Create a copy of CampaignState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampaignErrorCopyWith<CampaignError> get copyWith => _$CampaignErrorCopyWithImpl<CampaignError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampaignError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CampaignState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $CampaignErrorCopyWith<$Res> implements $CampaignStateCopyWith<$Res> {
  factory $CampaignErrorCopyWith(CampaignError value, $Res Function(CampaignError) _then) = _$CampaignErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CampaignErrorCopyWithImpl<$Res>
    implements $CampaignErrorCopyWith<$Res> {
  _$CampaignErrorCopyWithImpl(this._self, this._then);

  final CampaignError _self;
  final $Res Function(CampaignError) _then;

/// Create a copy of CampaignState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CampaignError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CampaignDetailLoaded implements CampaignState {
  const CampaignDetailLoaded(this.apiResponse);
  

 final  ApiResponse apiResponse;

/// Create a copy of CampaignState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampaignDetailLoadedCopyWith<CampaignDetailLoaded> get copyWith => _$CampaignDetailLoadedCopyWithImpl<CampaignDetailLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampaignDetailLoaded&&const DeepCollectionEquality().equals(other.apiResponse, apiResponse));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(apiResponse));

@override
String toString() {
  return 'CampaignState.detailLoaded(apiResponse: $apiResponse)';
}


}

/// @nodoc
abstract mixin class $CampaignDetailLoadedCopyWith<$Res> implements $CampaignStateCopyWith<$Res> {
  factory $CampaignDetailLoadedCopyWith(CampaignDetailLoaded value, $Res Function(CampaignDetailLoaded) _then) = _$CampaignDetailLoadedCopyWithImpl;
@useResult
$Res call({
 ApiResponse apiResponse
});




}
/// @nodoc
class _$CampaignDetailLoadedCopyWithImpl<$Res>
    implements $CampaignDetailLoadedCopyWith<$Res> {
  _$CampaignDetailLoadedCopyWithImpl(this._self, this._then);

  final CampaignDetailLoaded _self;
  final $Res Function(CampaignDetailLoaded) _then;

/// Create a copy of CampaignState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? apiResponse = freezed,}) {
  return _then(CampaignDetailLoaded(
freezed == apiResponse ? _self.apiResponse : apiResponse // ignore: cast_nullable_to_non_nullable
as ApiResponse,
  ));
}


}

// dart format on
