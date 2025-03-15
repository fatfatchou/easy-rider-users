import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users/core/global.dart';
import 'package:users/core/theme.dart';
import 'package:users/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:users/features/splash/presentation/bloc/splash_event.dart';
import 'package:users/onboarding/onboarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  startTimer() {
    Timer(
      const Duration(seconds: 3),
      () {
        if (firebaseAuth.currentUser != null) {
          BlocProvider.of<SplashBloc>(context)
              .add(ReadCurrentOnlineUserInfoEvent());
          Navigator.pushReplacementNamed(context, '/tab');
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const OnboardingPage(),));
        }
      },
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }
}
