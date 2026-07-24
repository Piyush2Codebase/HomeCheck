import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homecheck_app/features/trusted_contacts/data/repositories/flutter_contact_picker_repository.dart';
import 'package:homecheck_app/features/trusted_contacts/data/repositories/local_trusted_contacts_repository.dart';
import 'package:homecheck_app/features/trusted_contacts/domain/repositories/contact_picker_repository.dart';
import 'package:homecheck_app/features/trusted_contacts/domain/repositories/trusted_contacts_repository.dart';
import 'package:homecheck_app/features/trusted_contacts/domain/usecases/add_trusted_contact.dart';
import 'package:homecheck_app/features/trusted_contacts/domain/usecases/get_trusted_contacts.dart';
import 'package:homecheck_app/features/trusted_contacts/domain/usecases/remove_trusted_contact.dart';

final trustedContactsRepositoryProvider = Provider<TrustedContactsRepository>((
  ref,
) {
  return LocalTrustedContactsRepository();
});

final contactPickerRepositoryProvider = Provider<ContactPickerRepository>((
  ref,
) {
  return FlutterContactPickerRepository();
});

final getTrustedContactsProvider = Provider<GetTrustedContacts>((ref) {
  return GetTrustedContacts(ref.read(trustedContactsRepositoryProvider));
});

final addTrustedContactProvider = Provider<AddTrustedContact>((ref) {
  return AddTrustedContact(ref.read(trustedContactsRepositoryProvider));
});

final removeTrustedContactProvider = Provider<RemoveTrustedContact>((ref) {
  return RemoveTrustedContact(ref.read(trustedContactsRepositoryProvider));
});
