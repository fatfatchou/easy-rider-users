import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users/core/theme.dart';
import 'package:users/di_container.dart';
import 'package:users/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:users/features/auth/presentation/pages/login_page.dart';
import 'package:users/features/auth/presentation/pages/register_page.dart';
import 'package:users/home_page.dart';
import 'package:users/onboarding/onboarding_page.dart';
import 'package:users/onboarding/welcome_page.dart';

void main() async {
  // Setting up getIt
  setUpDependencies();

  // Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            registerUseCase: sl(),
            loginUseCase: sl(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Easy Rider',
        theme: lightTheme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
        home: const OnboardingPage(),
        routes: {
          '/welcome': (_) => const WelcomePage(),
          '/register': (_) => const RegisterPage(),
          '/login': (_) => const LoginPage(),
          '/tab': (_) => const HomePage(),
        },
      ),
    );
  }
}
