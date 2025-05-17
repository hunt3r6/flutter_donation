import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_donation/resource/model/campaign_model.dart';
import 'package:flutter_donation/resource/model/category_model.dart';
import 'package:flutter_donation/resource/model/slider_model.dart';

class HomeRemoteResource {
  final Dio _dio;

  HomeRemoteResource(this._dio);
  Future<Either<String, List<SliderModel>>> getSliders() async {
    try {
      final response = await _dio.get('slider');
      final sliders = response.data['data'];
      return Right(
        (sliders as List).map((e) => SliderModel.fromMap(e)).toList(),
      );
    } on DioException catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<CategoryModel>>> getCategories() async {
    try {
      final response = await _dio.get('category');
      final categories = response.data['data']['data'];
      return Right(
        (categories as List).map((e) => CategoryModel.fromMap(e)).toList(),
      );
    } on DioException catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<CampaignModel>>> getCampaignsByCategory(
    String slugCategory,
  ) async {
    try {
      final response = await _dio.get('category/$slugCategory');
      final categories = response.data['data']['campaigns'];
      return Right(
        (categories as List).map((e) => CampaignModel.fromJson(e)).toList(),
      );
    } on DioException catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<CampaignModel>>> getCampaigns() async {
    try {
      final response = await _dio.get('campaign');
      final campaigns = response.data['data']['data'];
      return Right(
        (campaigns as List).map((e) => CampaignModel.fromJson(e)).toList(),
      );
    } on DioException catch (e) {
      return Left(e.toString());
    }
  }
}
