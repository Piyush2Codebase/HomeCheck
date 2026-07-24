import 'package:homecheck_app/features/trusted_contacts/domain/entities/trusted_contact.dart';
import 'package:homecheck_app/features/trusted_contacts/domain/repositories/trusted_contacts_repository.dart';

class GetTrustedContacts {
  const GetTrustedContacts(this._repository);

  final TrustedContactsRepository _repository;

  Future<List<TrustedContact>> call() => _repository.getContacts();
}
