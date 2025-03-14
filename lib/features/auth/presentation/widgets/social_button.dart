import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:users/core/theme.dart';

class SocialButton extends StatelessWidget {
  final String iconPath;
  
  const SocialButton({super.key, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.gray200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: SvgPicture.asset(
          iconPath,
          width: 28,
          height: 28,
        ),
      ),
    );
  }
}
