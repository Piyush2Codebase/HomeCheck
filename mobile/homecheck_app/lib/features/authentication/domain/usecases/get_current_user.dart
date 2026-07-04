import 'package:homecheck_app/features/authentication/domain/entities/auth_user.dart';
import 'package:homecheck_app/features/authentication/domain/repositories/auth_repository.dart';

class GetCurrentUser {
  const GetCurrentUser(this._repository);

  final AuthRepository _repository;

  Future<AuthUser?> call() {
    return _repository.getCurrentUser();
  }
}
