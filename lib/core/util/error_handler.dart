class ErrorHandler {
  static Map<String, String> parseErrors(Map<String, dynamic> errors) {
    Map<String, String> errorMessages = {};

    errors.forEach((key, value) {
      if (value is List && value.isNotEmpty) {
        errorMessages[key] = value.first; // Ambil pesan error pertama
      }
    });

    return errorMessages;
  }
}
