import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:users/core/theme.dart';
import 'package:users/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:users/features/auth/presentation/bloc/auth_state.dart';
import 'package:users/features/auth/presentation/bloc/auth_event.dart';
import 'package:users/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:users/features/auth/presentation/widgets/custom_button.dart';

class SetPasswordPage extends StatefulWidget {
  final String name;
  final String email;
  final String phone;

  const SetPasswordPage({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
  });

  @override
  State<SetPasswordPage> createState() => _SetPasswordPageState();
}

class _SetPasswordPageState extends State<SetPasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  // declare a Golbal Key
  final _formKey = GlobalKey<FormState>();

  Future<void> _onRegister() async {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        RegisterEvent(
          name: widget.name.trim(),
          email: widget.email.trim(),
          phone: widget.phone.trim(),
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
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(Icons.arrow_back_ios_new,
                            color: AppColors.contentPrimary),
                        SizedBox(width: 5),
                        Text(
                          "Back",
                          style: TextStyle(
                            color: AppColors.contentSecondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                leadingWidth: 100,
                backgroundColor: darkTheme ? Colors.black : Colors.white,
                surfaceTintColor: darkTheme ? Colors.black : Colors.white,
                bottom: const PreferredSize(
                  preferredSize: Size.zero,
                  child: Column(
                    children: [
                      Text(
                        'Set Password',
                        style: TextStyle(
                          fontSize: 24,
                          color: AppColors.contentPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        "Set your password",
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColors.gray400,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: AuthInputField(
                          hint: "Enter Your Password",
                          controller: _passwordController,
                          isPassword: true,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _confirmController,
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          hintStyle: const TextStyle(color: AppColors.gray200),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: AppColors.gray300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: AppColors.gray300),
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
                            color: AppColors.contentPrimary,
                            fontWeight: FontWeight.w400),
                        cursorColor: AppColors.contentSecondary,
                        onChanged: (value) => setState(() {
                          _confirmController.text = value;
                        }),
                        validator: (value) {
                          if (_confirmController.text.trim() == '' ||
                              _confirmController.text.isEmpty) {
                            return "Please fill in this field";
                          } else if (_passwordController.text.trim() == '' ||
                              _passwordController.text.isEmpty) {
                            return "Please enter the password first";
                          } else if (_confirmController.text.trim() !=
                              _passwordController.text.trim()) {
                            return "Does not match the password";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 43),
                      CustomButton(
                        text: "Register",
                        onPress: _onRegister,
                      )
                    ],
                  ),
                ),
              ),
            ),
            if (state is AuthLoadingState)
              Container(
                color:
                    Colors.black.withOpacity(0.5),
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
