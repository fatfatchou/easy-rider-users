import 'package:flutter/material.dart';
import 'package:users/core/theme.dart';

class ProgressDialog extends StatelessWidget {
  final String message;

  const ProgressDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.gray100,
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.yellow700),
              ),
            ),
            Text(message),
          ],
        ),
      ),
    );
  }
}
