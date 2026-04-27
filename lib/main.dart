import 'package:flutter/material.dart';
import 'package:my_therapy/common/screens/splash_screen.dart';
import 'package:my_therapy/common/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: AppTheme.lightTheme,
    home: SplashScreen(),
    );
  }
}

