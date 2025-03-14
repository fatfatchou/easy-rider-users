import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:users/core/theme.dart';
import 'package:users/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:users/features/auth/presentation/bloc/auth_event.dart';
import 'package:users/features/auth/presentation/bloc/auth_state.dart';
import 'package:users/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:users/features/auth/presentation/widgets/custom_button.dart';
import 'package:users/features/auth/presentation/widgets/social_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // declare a Golbal Key
  final _formKey = GlobalKey<FormState>();

  Future<void> _onLogin() async {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        LoginEvent(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool darkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          Fluttertoast.showToast(msg: state.message);

          Navigator.pushNamedAndRemoveUntil(context, '/tab', (route) => false);
        } else if (state is AuthFailureState) {
          Fluttertoast.showToast(msg: state.message);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
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
                        'Sign in',
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Email Input
                        AuthInputField(
                            hint: 'Email',
                            controller: _emailController,
                            isEmail: true),

                        const SizedBox(height: 20),

                        // Password Input
                        AuthInputField(
                            hint: 'Enter Your Password',
                            controller: _passwordController,
                            isPassword: true),

                        const SizedBox(height: 20),

                        // Login Button
                        CustomButton(
                          text: 'Sign In',
                          onPress: _onLogin,
                        ),

                        const SizedBox(height: 20),

                        // Divider
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
                        ),

                        const SizedBox(height: 20),

                        // Social buttons
                        const SocialButton(iconPath: 'assets/icons/google.svg'),

                        const SizedBox(height: 50),

                        // Bottom Prompt
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                color: AppColors.contentTertiary,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, '/register');
                              },
                              child: const Text(
                                "Sign up",
                                style: TextStyle(
                                  color: AppColors.primary700,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (state is AuthLoadingState)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
