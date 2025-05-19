class DateUtilsHelper {
  /// Menghitung berapa hari lagi menuju [targetDate] dari hari ini.
  /// Jika tanggal sudah lewat, akan mengembalikan 0.
  static int daysUntil(DateTime targetDate) {
    DateTime today = DateTime.now();

    // Normalisasi ke tanggal saja (tanpa jam)
    DateTime todayOnly = DateTime(today.year, today.month, today.day);
    DateTime targetOnly = DateTime(
      targetDate.year,
      targetDate.month,
      targetDate.day,
    );

    int diff = targetOnly.difference(todayOnly).inDays;

    // Jika sudah lewat, kembalikan 0
    return diff < 0 ? 0 : diff;
  }

  /// Format tanggal menjadi string dd-mm-yyyy
  static String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year}";
  }
}
