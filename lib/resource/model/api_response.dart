import 'package:flutter_donation/resource/model/donation_model.dart';

class ApiResponse<T> {
  final bool success;
  final String message;
  final dynamic data;
  final List<DonationModel> donations;

  ApiResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.donations,
  });

  /// Factory method untuk menangani List dan Single Object
  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    final rawData = json['data'];

    return ApiResponse(
      success: json['success'],
      message: json['message'],
      data:
          (rawData is List)
              ? rawData
                  .map((item) => fromJsonT(item))
                  .toList() // Jika List<T>
              : fromJsonT(rawData), // Jika Single T
      donations:
          json['donations'].map<DonationModel>((item) {
            return DonationModel.fromMap(item);
          }).toList(),
    );
  }
}
