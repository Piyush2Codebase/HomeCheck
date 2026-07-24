import 'package:homecheck_app/features/trusted_contacts/domain/entities/trusted_contact.dart';
import 'package:homecheck_app/features/trusted_contacts/domain/repositories/trusted_contacts_repository.dart';

class AddTrustedContact {
  const AddTrustedContact(this._repository);

  final TrustedContactsRepository _repository;

  Future<void> call(TrustedContact contact) => _repository.addContact(contact);
}
