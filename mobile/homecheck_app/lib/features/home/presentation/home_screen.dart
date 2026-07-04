import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homecheck_app/features/authentication/presentation/controllers/auth_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final user = authState.user;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: authState.isLoading
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Welcome ${user?.displayName ?? 'User'}'),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        ref.read(authControllerProvider.notifier).signOut();
                      },
                      child: const Text('Sign Out'),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
