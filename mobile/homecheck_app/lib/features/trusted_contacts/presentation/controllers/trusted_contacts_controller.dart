import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homecheck_app/features/trusted_contacts/presentation/controllers/trusted_contacts_providers.dart';
import 'package:homecheck_app/features/trusted_contacts/presentation/controllers/trusted_contacts_state.dart';

class TrustedContactsController extends Notifier<TrustedContactsState> {
  @override
  TrustedContactsState build() {
    Future.microtask(_loadContacts);

    return const TrustedContactsState();
  }

  Future<void> _loadContacts() async {
    final contacts = await ref.read(getTrustedContactsProvider)();

    state = state.copyWith(contacts: contacts);
  }

  Future<void> pickAndAddContact() async {
    state = state.copyWith(isBusy: true, clearError: true);

    try {
      final picked = await ref.read(contactPickerRepositoryProvider).pickContact();

      if (picked == null) {
        state = state.copyWith(isBusy: false);

        return;
      }

      await ref.read(addTrustedContactProvider)(picked);
      await _loadContacts();

      state = state.copyWith(isBusy: false);
    } catch (_) {
      state = state.copyWith(
        isBusy: false,
        errorMessage: 'Could not add that contact.',
      );
    }
  }

  Future<void> removeContact(String id) async {
    await ref.read(removeTrustedContactProvider)(id);
    await _loadContacts();
  }
}

final trustedContactsControllerProvider =
    NotifierProvider<TrustedContactsController, TrustedContactsState>(
      TrustedContactsController.new,
    );
