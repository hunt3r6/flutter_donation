import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_donation/resource/model/donation_model.dart';
import 'package:flutter_donation/resource/model/paging_model.dart';

class DonationRemoteResource {
  final Dio dio;

  DonationRemoteResource(this.dio);
  Future<Either<String, PagingModel>> fecthDonations({int page = 1}) async {
    try {
      final response = await dio.get('donation?page=$page');
      final result = PagingModel.fromMap(
        response.data['data'],
        DonationModel.fromMap,
      );
      return Right(result);
    } on DioException catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> donate(
    String pray, {
    required String amount,
    required String slug,
  }) async {
    try {
      final response = await dio.post(
        'donation',
        data: {'amount': amount, 'pray': pray, 'campaignSlug': slug},
      );
      final token = response.data['0']['snap_token'];
      return Right(token);
    } on DioException catch (e) {
      return Left(e.toString());
    }
  }
}
