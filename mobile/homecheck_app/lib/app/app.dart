import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homecheck_app/app/routes/app_router.dart';
import 'package:homecheck_app/core/theme/app_theme.dart';

class HomeCheckApp extends ConsumerWidget {
  const HomeCheckApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'HomeCheck',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}
