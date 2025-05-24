import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_donation/resource/model/user_model.dart';
import 'package:flutter_donation/resource/remote/profile_remote_resource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.dart';
part 'profile_cubit.freezed.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRemoteResource profileRemoteResource;
  ProfileCubit(this.profileRemoteResource) : super(ProfileState.initial());

  getProfile() async {
    emit(ProfileState.loading());
    final result = await profileRemoteResource.fetchUserProfile();
    result.fold(
      (error) => emit(ProfileState.error(error)),
      (user) => emit(ProfileState.loaded(user)),
    );
  }

  updateProfile({required String name, required File? avatar}) async {
    emit(ProfileState.updating());
    final result = await profileRemoteResource.updateUserProfile(
      name: name,
      avatar: avatar,
    );
    result.fold((error) => emit(ProfileState.error(error)), (message) async {
      emit(ProfileState.profileUpdated(message));
      // Ambil ulang data profil terbaru
      final profileResult = await profileRemoteResource.fetchUserProfile();
      profileResult.fold(
        (error) => emit(ProfileState.error(error)),
        (user) => emit(ProfileState.loaded(user)),
      );
    });
  }

  updatePassword({
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(ProfileState.updating());
    final result = await profileRemoteResource.updatePassword(
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
    result.fold(
      (error) => emit(ProfileState.error(error)),
      (message) => emit(ProfileState.passwordUpdated(message)),
    );
  }
}
