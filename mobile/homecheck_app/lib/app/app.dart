import 'package:flutter/material.dart';
import 'package:homecheck_app/app/routes/app_router.dart';
import 'package:homecheck_app/core/theme/app_theme.dart';

class HomeCheckApp extends StatelessWidget {
  const HomeCheckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'HomeCheck',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
