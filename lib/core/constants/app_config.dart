class AppConfig {
  AppConfig._();
  static String get baseUrl => 'https://donasi.appdev.my.id/';
  static String get apiPatch => '$baseUrl/api/';
  static String get urlPayment =>
      'https://app.sandbox.midtrans.com/snap/v2/vtweb/';
}
