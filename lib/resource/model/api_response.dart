class ApiResponse<T> {
  final bool success;
  final String message;
  final dynamic data;

  ApiResponse({
    required this.success,
    required this.message,
    required this.data,
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
    );
  }
}
