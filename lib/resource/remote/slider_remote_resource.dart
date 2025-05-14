import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_donation/resource/model/slider_model.dart';

class SliderRemoteResource {
  final Dio _dio;

  SliderRemoteResource(this._dio);
  Future<Either<String, List<SliderModel>>> getSliders() async {
    try {
      final response = await _dio.get('sliders');
      return Right(
        (response.data as List).map((e) => SliderModel.fromMap(e)).toList(),
      );
    } on DioException catch (e) {
      return Left(e.toString());
    }
  }
}
