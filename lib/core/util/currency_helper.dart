import 'package:intl/intl.dart';

class CurrencyHelper {
  /// Format angka menjadi mata uang Rupiah (IDR)
  static String formatRupiah(double amount, {int decimal = 0}) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: decimal,
    );
    return formatter.format(amount);
  }

  /// Format angka menjadi mata uang Dollar (USD)
  static String formatDollar(double amount, {int decimal = 2}) {
    final formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: '\$',
      decimalDigits: decimal,
    );
    return formatter.format(amount);
  }

  /// Format angka ke mata uang dengan lokal dan simbol tertentu
  static String formatCurrency(
    double amount, {
    required String locale,
    required String symbol,
    int decimalDigits = 2,
  }) {
    final formatter = NumberFormat.currency(
      locale: locale,
      symbol: symbol,
      decimalDigits: decimalDigits,
    );
    return formatter.format(amount);
  }
}
