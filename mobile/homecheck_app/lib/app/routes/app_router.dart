import 'package:go_router/go_router.dart';
import 'package:homecheck_app/app/routes/app_routes.dart';
import 'package:homecheck_app/features/authentication/presentation/screens/login_screen.dart';
import 'package:homecheck_app/features/home/presentation/home_screen.dart';
import 'package:homecheck_app/features/splash/presentation/splash_screen.dart';

abstract final class AppRouter {
  static final GoRouter router = GoRouter(
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
    ],
  );
}
