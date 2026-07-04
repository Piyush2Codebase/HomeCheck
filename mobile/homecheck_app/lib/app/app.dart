import 'package:flutter/material.dart';
import 'package:homecheck_app/core/theme/app_theme.dart';
import 'package:homecheck_app/features/splash/presentation/splash_screen.dart';

class HomeCheckApp extends StatelessWidget {
  const HomeCheckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomeCheck',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
