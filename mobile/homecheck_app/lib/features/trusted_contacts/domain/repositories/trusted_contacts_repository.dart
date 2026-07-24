import 'package:homecheck_app/features/trusted_contacts/domain/entities/trusted_contact.dart';

abstract interface class TrustedContactsRepository {
  Future<List<TrustedContact>> getContacts();

  Future<void> addContact(TrustedContact contact);

  Future<void> removeContact(String id);
}
