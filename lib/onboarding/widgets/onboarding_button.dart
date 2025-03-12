import 'package:flutter/material.dart';
import 'package:users/core/theme.dart';

class OnboardingButton extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onPressed;

  const OnboardingButton({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: CircularProgressIndicator(
            value: (currentPage + 1) / totalPages,
            strokeWidth: 4,
            backgroundColor: AppColors.primary100,
            valueColor:
                const AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
          ),
        ),
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
            backgroundColor: AppColors.primaryColor,
            elevation: 1,
          ),
          child: currentPage == 2
              ? const Text(
                  'Go',
                  style:
                      TextStyle(fontSize: 20, color: AppColors.contentTertiary),
                )
              : const Icon(Icons.arrow_forward,
                  color: AppColors.contentTertiary),
        ),
      ],
    );
  }
}
