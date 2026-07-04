import 'package:homecheck_app/features/authentication/domain/entities/auth_user.dart';
import 'package:homecheck_app/features/authentication/domain/repositories/auth_repository.dart';

class FakeAuthRepository implements AuthRepository {
  AuthUser? _currentUser;

  @override
  Future<AuthUser?> getCurrentUser() async {
    await Future<void>.delayed(const Duration(seconds: 2));

    return _currentUser;
  }

  @override
  Future<AuthUser> signIn() async {
    await Future<void>.delayed(const Duration(seconds: 1));

    const user = AuthUser(
      id: 'fake-user-1',
      email: 'piyush@example.com',
      displayName: 'Piyush',
    );

    _currentUser = user;

    return user;
  }

  @override
  Future<void> signOut() async {
    _currentUser = null;
  }
}
