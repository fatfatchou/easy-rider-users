import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:users/core/theme.dart';
import 'package:users/features/auth/presentation/widgets/auth_input_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // declare a Golbal Key

  @override
  Widget build(BuildContext context) {
    bool darkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 100),
        child: Column(
          children: [
            const Text(
              'Sign up',
              style: TextStyle(
                fontSize: 24,
                color: AppColors.contentPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            AuthInputField(hint: 'Name', controller: _nameController),
            const SizedBox(height: 20),
            AuthInputField(hint: 'Email', controller: _emailController),
            const SizedBox(height: 20),
            AuthInputField(hint: 'Phone', controller: _phoneController),
            const SizedBox(height: 20),
            AuthInputField(hint: 'Address', controller: _addressController),
            const SizedBox(height: 20),
            Row(
              children: [
                SvgPicture.asset('assets/icons/check-circle.svg'),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'By signing up. you agree to the Terms of service and Privacy policy.',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
