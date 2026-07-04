import 'package:homecheck_app/features/authentication/domain/entities/auth_status.dart';
import 'package:homecheck_app/features/authentication/domain/entities/auth_user.dart';

class AuthState {
  const AuthState({required this.status, this.user, this.isLoading = false});

  const AuthState.initial()
    : status = AuthStatus.initial,
      user = null,
      isLoading = false;

  final AuthStatus status;
  final AuthUser? user;
  final bool isLoading;

  AuthState copyWith({
    AuthStatus? status,
    AuthUser? user,
    bool? isLoading,
    bool clearUser = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: clearUser ? null : user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
