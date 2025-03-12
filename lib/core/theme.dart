import 'package:flutter/material.dart';

class AppColors {
  // Primary
  static const Color primary50 = Color(0xFFFFFBE7);
  static const Color primary100 = Color(0xFFFFF1B1);
  static const Color primary200 = Color(0xFFFFE773);
  static const Color primary300 = Color(0xFFFBDB86);
  static const Color primary400 = Color(0xFFF6CD56);
  static const Color primary500 = Color(0xFFF5C73F);
  static const Color primary600 = Color(0xFFF5BF28);
  static const Color primary700 = Color(0xFFEDAE10);
  static const Color primary800 = Color(0xFFF4BE05);
  static const Color primary900 = Color(0xFFF3BD06);

  // Secondary
  static const Color secondary50 = Color(0xFFFCE2E7);
  static const Color secondary100 = Color(0xFFF88BC3);
  static const Color secondary200 = Color(0xFFF2899B);
  static const Color secondary300 = Color(0xFFEA5A75);
  static const Color secondary400 = Color(0xFFE23859);
  static const Color secondary500 = Color(0xFFDB1740);
  static const Color secondary600 = Color(0xFFCB103F);
  static const Color secondary700 = Color(0xFFB7083C);
  static const Color secondary800 = Color(0xFFA4003B);
  static const Color secondary900 = Color(0xFF820036);

  // Warning
  static const Color yellow50 = Color(0xFFFFFDE7);
  static const Color yellow100 = Color(0xFFFFF9C4);
  static const Color yellow200 = Color(0xFFFFF59D);
  static const Color yellow300 = Color(0xFFFEF075);
  static const Color yellow400 = Color(0xFFFCEB55);
  static const Color yellow500 = Color(0xFFFAE635);
  static const Color yellow600 = Color(0xFFFDD835);
  static const Color yellow700 = Color(0xFFFBc02D);
  static const Color yellow800 = Color(0xFFF9A825);
  static const Color yellow900 = Color(0xFFF57F17);

  // Error
  static const Color red50 = Color(0xFFFFEBEE);
  static const Color red100 = Color(0xFFFFCDD2);
  static const Color red200 = Color(0xFFEF9A9A);
  static const Color red300 = Color(0xFFE57373);
  static const Color red400 = Color(0xFFEF5350);
  static const Color red500 = Color(0xFFF44336);
  static const Color red600 = Color(0xFFE53935);
  static const Color red700 = Color(0xFFD32F2F);
  static const Color red800 = Color(0xFFC62828);
  static const Color red900 = Color(0xFFB71C1C);

  // Success
  static const Color green50 = Color(0xFFE8F5E9);
  static const Color green100 = Color(0xFFC8E6C9);
  static const Color green200 = Color(0xFFA5D6A7);
  static const Color green300 = Color(0xFF81C784);
  static const Color green400 = Color(0xFF66BB6B);
  static const Color green500 = Color(0xFF4CAF51);
  static const Color green600 = Color(0xFF43A048);
  static const Color green700 = Color(0xFF388E3D);
  static const Color green800 = Color(0xFF2E7D33);
  static const Color green900 = Color(0xFF1B5E21);

  // Neutral
  static const Color gray50 = Color(0xFFF7F7F7);
  static const Color gray100 = Color(0xFFE8E8E8);
  static const Color gray200 = Color(0xFFD0D0D0);
  static const Color gray300 = Color(0xFFB8B8B8);
  static const Color gray400 = Color(0xFFA0A0A0);
  static const Color gray500 = Color(0xFF898989);
  static const Color gray600 = Color(0xFF717171);
  static const Color contentTertiary = Color(0xFF5A5A5A);
  static const Color contentSecondary = Color(0xFF414141);
  static const Color contentPrimary = Color(0xFF2A2A2A);

  // Main color
  static const Color primaryColor = Color(0xFFFEC400);
  static const Color secondaryColor = Color(0xFFB7083C);
  static const Color warningColor = Color(0xFFFB8A00);
  static const Color errorColor = Color(0xFFF44336);
  static const Color successColor = Color(0xFF43A048);
  static const Color infoColor = Color(0xFFB8B8B8);
}

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Poppins',
  primaryColor: AppColors.primary500,
  scaffoldBackgroundColor: Colors.white,
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'Poppins',
  primaryColor: AppColors.primary500,
  scaffoldBackgroundColor: Colors.black,
);


