import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homecheck_app/features/authentication/presentation/controllers/auth_controller.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: authState.isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () {
                    ref.read(authControllerProvider.notifier).signIn();
                  },
                  child: const Text('Sign In'),
                ),
        ),
      ),
    );
  }
}
