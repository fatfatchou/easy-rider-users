import 'package:flutter/material.dart';
import 'package:users/core/theme.dart';

class AuthInputField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool isPassword;

  const AuthInputField({
    super.key,
    required this.hint,
    required this.controller,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.gray300)),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: AppColors.gray200),
            border: InputBorder.none),
        style: const TextStyle(color: Colors.black),
        cursorColor: AppColors.gray200,
      ),
    );
  }
}
