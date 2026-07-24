import 'dart:convert';

import 'package:homecheck_app/features/trusted_contacts/domain/entities/trusted_contact.dart';
import 'package:homecheck_app/features/trusted_contacts/domain/repositories/trusted_contacts_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalTrustedContactsRepository implements TrustedContactsRepository {
  static const _contactsKey = 'trusted_contacts.contacts';

  @override
  Future<List<TrustedContact>> getContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_contactsKey);

    if (raw == null) {
      return [];
    }

    final decoded = jsonDecode(raw) as List<dynamic>;

    return decoded
        .map(
          (entry) => TrustedContact.fromJson(entry as Map<String, dynamic>),
        )
        .toList();
  }

  @override
  Future<void> addContact(TrustedContact contact) async {
    final contacts = await getContacts();
    contacts.add(contact);
    await _persist(contacts);
  }

  @override
  Future<void> removeContact(String id) async {
    final contacts = await getContacts();
    contacts.removeWhere((contact) => contact.id == id);
    await _persist(contacts);
  }

  Future<void> _persist(List<TrustedContact> contacts) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(contacts.map((c) => c.toJson()).toList());
    await prefs.setString(_contactsKey, encoded);
  }
}
