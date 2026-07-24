import 'package:homecheck_app/features/trusted_contacts/domain/repositories/trusted_contacts_repository.dart';

class RemoveTrustedContact {
  const RemoveTrustedContact(this._repository);

  final TrustedContactsRepository _repository;

  Future<void> call(String id) => _repository.removeContact(id);
}
