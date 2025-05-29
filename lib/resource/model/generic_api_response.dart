import 'package:flutter_donation/resource/model/paging_model.dart';

class GenericApiResponse<T> {
  final bool success;
  final String message;
  final PagingModel<T> paginationData;

  GenericApiResponse({
    required this.success,
    required this.message,
    required this.paginationData,
  });

  factory GenericApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> itemJson) fromJsonT,
  ) {
    return GenericApiResponse<T>(
      success: json['success'],
      message: json['message'],
      paginationData: PagingModel<T>.fromJson(
        json['data'],
        fromJsonT, // <-- Teruskan fungsi fromJsonT
      ),
    );
  }
}
