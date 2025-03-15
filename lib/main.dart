import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:users/core/theme.dart';
import 'package:users/di_container.dart';
import 'package:users/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:users/features/auth/presentation/pages/login_page.dart';
import 'package:users/features/auth/presentation/pages/register_page.dart';
import 'package:users/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:users/features/splash/presentation/pages/splash_page.dart';
import 'package:users/onboarding/welcome_page.dart';
import 'package:users/tabs_page.dart';

void main() async {
  // Setting up getIt
  setUpDependencies();

  // Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await setUpMapbox();

  runApp(const MyApp());
}

Future<void> setUpMapbox() async {
  await dotenv.load(fileName: '.env');
  MapboxOptions.setAccessToken(dotenv.env['MAPBOX_ACCESS_TOKEN']!);
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
            resetPasswordUseCase: sl(),
          ),
        ),
        BlocProvider(
          create: (_) => SplashBloc(
            readCurrentOnlineUserInfoUseCase: sl(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Easy Rider',
        theme: lightTheme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
        home: const SplashPage(),
        routes: {
          '/welcome': (_) => const WelcomePage(),
          '/register': (_) => const RegisterPage(),
          '/login': (_) => const LoginPage(),
          '/tab': (_) => const TabsPage(),
        },
      ),
    );
  }
}
