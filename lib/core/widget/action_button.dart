import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color? colorButton;
  final Color? colorText;
  const ActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.colorButton,
    this.colorText,
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
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
