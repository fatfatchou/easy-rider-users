import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:users/core/theme.dart';
import 'package:users/features/auth/presentation/pages/set_password_page.dart';
import 'package:users/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:users/features/auth/presentation/widgets/custom_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // declare a Golbal Key
  final _formKey = GlobalKey<FormState>();

  void _continue() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SetPasswordPage(
            name: _nameController.text,
            email: _emailController.text,
            phoneNum: _phoneController.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool darkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: darkTheme ? Colors.black : Colors.white,
        surfaceTintColor: darkTheme ? Colors.black : Colors.white,
        bottom: const PreferredSize(
          preferredSize: Size.zero,
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                'Sign up',
                style: TextStyle(
                  fontSize: 24,
                  color: AppColors.contentPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        titleSpacing: 18.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AuthInputField(
                    hint: 'Name', controller: _nameController, isName: true),
                const SizedBox(height: 20),
                AuthInputField(
                    hint: 'Email', controller: _emailController, isEmail: true),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/vn-flag.svg',
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            '+84',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.contentPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                    hintText: 'Your mobile number',
                    hintStyle: const TextStyle(
                      color: AppColors.gray200,
                    ),
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
                      borderSide:
                          const BorderSide(color: AppColors.contentPrimary),
                    ),
                  ),
                  style: const TextStyle(
                      color: AppColors.contentPrimary,
                      fontWeight: FontWeight.w400),
                  cursorColor: AppColors.contentSecondary,
                  autovalidateMode: AutovalidateMode.onUnfocus,
                  onChanged: (value) => setState(() {
                    _phoneController.text = value;
                  }),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please fill in this field";
                    }
                    if (int.tryParse(value.trim()) == null || value.trim().length != 9) {
                      return "Invalid phone number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/check-circle.svg'),
                    const SizedBox(width: 12),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.gray300,
                              fontWeight: FontWeight.w500),
                          children: [
                            const TextSpan(
                                text: "By signing up, you agree to the "),
                            TextSpan(
                              text: "Terms of service",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                            const TextSpan(text: " and "),
                            TextSpan(
                              text: "Privacy policy.",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: 'Continue',
                  onPress: _continue,
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: AppColors.gray300,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      child: Text(
                        'or',
                        style: TextStyle(
                            color: AppColors.gray300,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: AppColors.gray300,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
