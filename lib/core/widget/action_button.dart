// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color? colorButton;
  final Color? colorText;
  final int? fontSize;
  const ActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.colorButton,
    this.colorText,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: FilledButton.tonal(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(colorButton ?? Colors.blue),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            color: colorText ?? Colors.white,
            fontSize: fontSize?.toDouble(),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
