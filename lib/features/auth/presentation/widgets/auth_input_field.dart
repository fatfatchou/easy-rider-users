import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:users/core/theme.dart';

class AuthInputField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final bool isName;
  final bool isEmail;
  final bool isPassword;

  const AuthInputField({
    super.key,
    required this.hint,
    required this.controller,
    this.isName = false,
    this.isEmail = false,
    this.isPassword = false, 
  });

  @override
  State<AuthInputField> createState() => _AuthInputFieldState();
}

class _AuthInputFieldState extends State<AuthInputField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUnfocus,
      obscureText: widget.isPassword,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: const TextStyle(color: AppColors.gray200),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.gray300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.gray300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.contentPrimary,
            width: 1.5,
          ),
        ),
      ),
      style: const TextStyle(
          color: AppColors.contentPrimary, fontWeight: FontWeight.w400),
      cursorColor: AppColors.contentSecondary,
      onChanged: (value) => setState(() {
        widget.controller.text = value;
      }),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please fill in this field";
        }

        if (widget.isName) {
          if (value.trim().length > 25) {
            return "Name cannot exceed 25 characters";
          }
        }

        if (widget.isEmail) {
          if (!EmailValidator.validate(value.trim())) {
            return "Invalid email";
          }
        }

        if(widget.isPassword) {
          if(value.trim().length < 8) {
            return "Password must have at least 8 characters";
          }
        }
        return null;
      },
    );
  }
}
