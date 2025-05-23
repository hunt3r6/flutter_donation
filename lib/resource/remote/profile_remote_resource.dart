import 'dart:io';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_donation/resource/model/user_model.dart';

class ProfileRemoteResource {
  final Dio _dio;

  ProfileRemoteResource(this._dio);

  Future<Either<String, UserModel>> fetchUserProfile() async {
    try {
      final response = await _dio.get('profile');
      return Right(UserModel.fromMap(response.data['data']));
    } on DioException catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> updateUserProfile({
    required String name,
    required File? avatar,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'name': name,
        'avatar':
            avatar != null ? await MultipartFile.fromFile(avatar.path) : null,
      });
      final response = await _dio.post(
        'profile',
        data: formData,
        options: Options(headers: {"content-type": "multipart/form-data"}),
      );
      return Right(response.data['message']);
    } on DioException catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> updatePassword({
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final response = await _dio.post(
        'profile/password',
        data: {
          'password': newPassword,
          'password_confirmation': confirmPassword,
        },
      );
      return Right(response.data['message']);
    } on DioException catch (e) {
      return Left(e.toString());
    }
  }
}
