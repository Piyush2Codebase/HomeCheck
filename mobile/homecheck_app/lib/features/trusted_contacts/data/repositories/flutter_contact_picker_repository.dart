import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:homecheck_app/features/trusted_contacts/domain/entities/trusted_contact.dart';
import 'package:homecheck_app/features/trusted_contacts/domain/repositories/contact_picker_repository.dart';

class FlutterContactPickerRepository implements ContactPickerRepository {
  @override
  Future<TrustedContact?> pickContact() async {
    await FlutterContacts.permissions.request(PermissionType.read);

    final contact = await FlutterContacts.native.showPicker(
      properties: {ContactProperty.phone},
    );

    if (contact == null || contact.phones.isEmpty) {
      return null;
    }

    final id = contact.id;

    return TrustedContact(
      id: (id == null || id.isEmpty)
          ? DateTime.now().microsecondsSinceEpoch.toString()
          : id,
      name: contact.displayName ?? contact.phones.first.number,
      phoneNumber: contact.phones.first.number,
    );
  }
}
