import 'package:intl/intl.dart';

class CurrencyHelper {
  /// Format angka menjadi mata uang Rupiah (IDR)
  static String formatRupiah(double amount, {int decimalDigits = 0}) {
    return formatCurrency(
      amount,
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: decimalDigits,
    );
  }

  /// Format angka menjadi mata uang Dollar (USD)
  static String formatDollar(double amount, {int decimalDigits = 2}) {
    return formatCurrency(
      amount,
      locale: 'en_US',
      symbol: '\$',
      decimalDigits: decimalDigits,
    );
  }

  /// Format angka ke mata uang dengan lokal tertentu.
  /// Simbol mata uang dapat disediakan secara eksplisit.
  /// Jika [symbol] tidak disediakan (null), maka simbol default dari [locale] akan digunakan.
  static String formatCurrency(
    double amount, {
    required String locale,
    String? symbol, // Ubah menjadi opsional
    int decimalDigits = 2,
  }) {
    final formatter = NumberFormat.currency(
      locale: locale,
      symbol:
          symbol, // Jika symbol null, intl akan menggunakan default untuk locale
      decimalDigits: decimalDigits,
    );
    return formatter.format(amount);
  }
}
