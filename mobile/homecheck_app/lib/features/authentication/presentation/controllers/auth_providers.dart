import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homecheck_app/features/authentication/data/repositories/fake_auth_repository.dart';
import 'package:homecheck_app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:homecheck_app/features/authentication/domain/usecases/get_current_user.dart';
import 'package:homecheck_app/features/authentication/domain/usecases/sign_in.dart';
import 'package:homecheck_app/features/authentication/domain/usecases/sign_out.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return FakeAuthRepository();
});

final getCurrentUserProvider = Provider<GetCurrentUser>((ref) {
  return GetCurrentUser(ref.read(authRepositoryProvider));
});

final signInProvider = Provider<SignIn>((ref) {
  return SignIn(ref.read(authRepositoryProvider));
});

final signOutProvider = Provider<SignOut>((ref) {
  return SignOut(ref.read(authRepositoryProvider));
});
