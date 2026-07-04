import 'package:homecheck_app/features/authentication/domain/entities/auth_status.dart';
import 'package:homecheck_app/features/authentication/domain/entities/auth_user.dart';

class AuthState {
  const AuthState({required this.status, this.user});

  const AuthState.initial() : status = AuthStatus.initial, user = null;

  final AuthStatus status;
  final AuthUser? user;
}
