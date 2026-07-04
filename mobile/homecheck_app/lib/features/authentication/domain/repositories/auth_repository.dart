import 'package:homecheck_app/features/authentication/domain/entities/auth_user.dart';

abstract interface class AuthRepository {
  Future<AuthUser?> getCurrentUser();

  Future<AuthUser> signIn();

  Future<void> signOut();
}
