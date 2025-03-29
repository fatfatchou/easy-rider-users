import 'package:flutter/material.dart';
import 'package:users/core/theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  final bool isSignout;

  const CustomButton({super.key, required this.text, required this.onPress, this.isSignout = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSignout ? AppColors.red700 : AppColors.primary700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
