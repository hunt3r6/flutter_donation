import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
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
}
