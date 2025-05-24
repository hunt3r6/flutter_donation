import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_donation/resource/model/donation_model.dart';

class DonationRemoteResource {
  final Dio dio;

  DonationRemoteResource(this.dio);
  Future<Either<String, List<DonationModel>>> fecthDonations() async {
    try {
      final response = await dio.get('donation');
      final donations = response.data['data']['data'];
      return Right(
        (donations as List).map((e) => DonationModel.fromMap(e)).toList(),
      );
    } on DioException catch (e) {
      return Left(e.toString());
    }
  }
}
