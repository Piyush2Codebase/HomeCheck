import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homecheck_app/features/authentication/domain/entities/auth_status.dart';
import 'package:homecheck_app/features/authentication/presentation/controllers/auth_providers.dart';
import 'package:homecheck_app/features/authentication/presentation/controllers/auth_state.dart';

class AuthController extends Notifier<AuthState> {
  @override
  AuthState build() {
    Future.microtask(checkAuthentication);

    return const AuthState.initial();
  }

  Future<void> checkAuthentication() async {
    final getCurrentUser = ref.read(getCurrentUserProvider);
    final user = await getCurrentUser();

    if (user == null) {
      state = const AuthState(status: AuthStatus.unauthenticated);

      return;
    }

    state = AuthState(status: AuthStatus.authenticated, user: user);
  }

  Future<void> signIn() async {
    state = state.copyWith(isLoading: true);

    final signIn = ref.read(signInProvider);
    final user = await signIn();

    state = AuthState(status: AuthStatus.authenticated, user: user);
  }

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true);

    final signOut = ref.read(signOutProvider);
    await signOut();

    state = const AuthState(status: AuthStatus.unauthenticated);
  }
}

final authControllerProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);
