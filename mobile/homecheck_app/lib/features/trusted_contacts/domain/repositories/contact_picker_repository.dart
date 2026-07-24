import 'package:homecheck_app/features/trusted_contacts/domain/entities/trusted_contact.dart';

abstract interface class ContactPickerRepository {
  Future<TrustedContact?> pickContact();
}
