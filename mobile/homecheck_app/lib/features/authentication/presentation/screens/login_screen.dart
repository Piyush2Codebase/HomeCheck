import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homecheck_app/app/routes/app_routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              context.go(AppRoutes.home);
            },
            child: const Text('Continue to Home'),
          ),
        ),
      ),
    );
  }
}
