import 'package:flutter/material.dart';
import 'package:users/core/theme.dart';

class OnboardingCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardingCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 250),
          const SizedBox(height: 40),
          Text(title,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.contentPrimary)),
          const SizedBox(height: 15),
          SizedBox(
            width: 350,
            child: Text(description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: AppColors.gray400)),
          ),
        ],
      ),
    );
  }
}
