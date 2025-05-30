import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_donation/resource/model/api_response.dart';
import 'package:flutter_donation/resource/model/campaign_model.dart';
import 'package:flutter_donation/resource/model/category_model.dart';
import 'package:flutter_donation/resource/model/paging_model.dart';
import 'package:flutter_donation/resource/model/slider_model.dart';

class HomeRemoteResource {
  final Dio _dio;

  HomeRemoteResource(this._dio);
  Future<Either<String, List<SliderModel>>> getSliders() async {
    try {
      final response = await _dio.get('slider');
      final sliders = response.data['data'];
      return Right(
        (sliders as List).map((slider) => SliderModel.fromMap(slider)).toList(),
      );
    } on DioException catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<CategoryModel>>> getCategories() async {
    try {
      final response = await _dio.get('category');
      final result = PagingModel.fromMap(
        response.data['data'],
        CategoryModel.fromMap,
      );
      return Right(result.data ?? []);
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
        (categories as List)
            .map((category) => CampaignModel.fromMap(category))
            .toList(),
      );
    } on DioException catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, PagingModel>> getCampaigns({
    String query = '',
    int page = 1,
  }) async {
    try {
      final response = await _dio.get('campaign?q=$query&page=$page');
      final result = PagingModel.fromMap(
        response.data['data'],
        CampaignModel.fromMap,
      );
      return Right(result);
    } on DioException catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, ApiResponse>> getDetailCampaign(String slug) async {
    try {
      final response = await _dio.get('campaign/$slug');
      return Right(ApiResponse.fromJson(response.data, CampaignModel.fromMap));
    } on DioException catch (e) {
      return Left(e.toString());
    }
  }
}
