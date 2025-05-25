import 'package:flutter/material.dart';

class FundProgressBar extends StatelessWidget {
  final double collectedAmount; // Dana terkumpul (dalam juta)
  final double maxAmount; // Target maksimal (dalam juta)

  const FundProgressBar({
    super.key,
    required this.collectedAmount,
    required this.maxAmount,
  });

  @override
  Widget build(BuildContext context) {
    // Hitung persentase progress
    final progress = collectedAmount / maxAmount;

    return LinearProgressIndicator(
      borderRadius: BorderRadius.circular(8),
      value: progress,
      minHeight: 8,
      backgroundColor: Colors.grey[300],
      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
    );
  }
}
