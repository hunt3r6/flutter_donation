import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_donation/resource/local/auth_local_resource.dart';
import 'package:flutter_donation/resource/local/user_local_resource.dart';
import 'package:flutter_donation/resource/model/auth_response_model.dart';
import 'package:flutter_donation/resource/model/user_model.dart';

class AuthRemoteResource {
  final Dio _dio;

  AuthRemoteResource(this._dio);

  Future<Either<String, AuthResponseModel>> login(
    String email,
    String password,
  ) async {
    try {
      final response = await _dio.post(
        "login",
        data: {'email': email, 'password': password},
      );
      String token = response.data['token'];
      final UserModel user = UserModel.fromMap(response.data['data']);
      await AuthLocalResource.saveToken(token);
      await UserLocalResource.saveUser(user);
      return Right(AuthResponseModel.fromMap(response.data));
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return Left(e.response?.data['message']);
      }
      return Left(e.toString());
    }
  }

  Future<Either<dynamic, String>> register(
    String name,
    String email,
    String password,
    String passwordConfirmation,
  ) async {
    log('Registering user: $name, $email');
    try {
      final response = await _dio.post(
        'register',
        data: {
          "name": name,
          "email": email,
          "password": password,
          "password_confirmation": passwordConfirmation,
        },
      );
      return Right(response.data['message']);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        log(e.response?.data.toString() ?? 'Error: No data');
        return Left(e.response?.data);
      }
      return Left(e.toString());
    }
  }
}
