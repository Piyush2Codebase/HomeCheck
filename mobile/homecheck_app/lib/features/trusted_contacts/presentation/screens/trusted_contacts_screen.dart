import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homecheck_app/features/trusted_contacts/presentation/controllers/trusted_contacts_controller.dart';
import 'package:homecheck_app/features/trusted_contacts/presentation/widgets/trusted_contact_tile.dart';

class TrustedContactsScreen extends ConsumerWidget {
  const TrustedContactsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(trustedContactsControllerProvider);

    ref.listen(trustedContactsControllerProvider, (previous, next) {
      if (next.errorMessage != null &&
          next.errorMessage != previous?.errorMessage) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.errorMessage!)));
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Trusted Contacts')),
      body: state.contacts.isEmpty
          ? const Center(child: Text('No trusted contacts yet'))
          : ListView.builder(
              itemCount: state.contacts.length,
              itemBuilder: (context, index) {
                final contact = state.contacts[index];

                return TrustedContactTile(
                  contact: contact,
                  onRemove: () {
                    ref
                        .read(trustedContactsControllerProvider.notifier)
                        .removeContact(contact.id);
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: state.isBusy
            ? null
            : () {
                ref
                    .read(trustedContactsControllerProvider.notifier)
                    .pickAndAddContact();
              },
        child: state.isBusy
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.add),
      ),
    );
  }
}
