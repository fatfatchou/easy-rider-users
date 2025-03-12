import 'package:flutter/material.dart';
import 'package:users/core/theme.dart';
import 'package:users/features/auth/presentation/pages/register_page.dart';
import 'package:users/onboarding/onboarding_page.dart';
import 'package:users/onboarding/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Rider',
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: const OnboardingPage(),
      routes: {
        '/welcome': (_) => const WelcomePage(), 
        '/register': (_) => const RegisterPage(),
      },
    );
  }
}
