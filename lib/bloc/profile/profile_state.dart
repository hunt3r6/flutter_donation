part of 'profile_cubit.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = ProfileInitial;
  const factory ProfileState.loading() = ProfileLoading;
  const factory ProfileState.updating() = ProfileUpdating;
  const factory ProfileState.loaded(UserModel user) = ProfileLoaded;
  const factory ProfileState.error(String message) = ProfileError;
  const factory ProfileState.profileUpdated(String message) = ProfileUpdated;
  const factory ProfileState.passwordUpdated(String message) =
      ProfilePasswordUpdated;
}
