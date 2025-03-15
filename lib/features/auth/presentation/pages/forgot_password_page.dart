import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:users/core/theme.dart';
import 'package:users/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:users/features/auth/presentation/bloc/auth_event.dart';
import 'package:users/features/auth/presentation/bloc/auth_state.dart';
import 'package:users/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:users/features/auth/presentation/widgets/custom_button.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // declare a Golbal Key
  final _formKey = GlobalKey<FormState>();

  Future<void> _onResetPassword() async {
    BlocProvider.of<AuthBloc>(context).add(
      ResetPasswordEvent(email: _emailController.text.trim()),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool darkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccessState) {
          Fluttertoast.showToast(msg: state.message);
         
        } else if (state is ResetPasswordFailureState) {
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
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Verification Email',
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
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AuthInputField(
                        hint: 'Enter Your Email',
                        controller: _emailController,
                        isEmail: true,
                      ),
                      const Spacer(),
                      CustomButton(
                        text: 'Reset Password',
                        onPress: _onResetPassword,
                      )
                    ],
                  ),
                ),
              ),
            ),
            if (state is ResetPasswordLoadingState)
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
