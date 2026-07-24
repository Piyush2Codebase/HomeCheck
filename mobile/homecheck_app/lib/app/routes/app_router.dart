import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:homecheck_app/app/routes/app_routes.dart';
import 'package:homecheck_app/features/authentication/domain/entities/auth_status.dart';
import 'package:homecheck_app/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:homecheck_app/features/authentication/presentation/screens/login_screen.dart';
import 'package:homecheck_app/features/home/presentation/home_screen.dart';
import 'package:homecheck_app/features/splash/presentation/splash_screen.dart';
import 'package:homecheck_app/features/trusted_contacts/presentation/screens/trusted_contacts_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authControllerProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.trustedContacts,
        builder: (context, state) => const TrustedContactsScreen(),
      ),
    ],
    redirect: (context, state) {
      final currentLocation = state.matchedLocation;
      final isAuthOnlyRoute =
          currentLocation == AppRoutes.splash || currentLocation == AppRoutes.login;

      switch (authState.status) {
        case AuthStatus.initial:
          return currentLocation == AppRoutes.splash ? null : AppRoutes.splash;

        case AuthStatus.unauthenticated:
          return currentLocation == AppRoutes.login ? null : AppRoutes.login;

        case AuthStatus.authenticated:
          return isAuthOnlyRoute ? AppRoutes.home : null;
      }
    },
  );
});
