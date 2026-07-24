import 'package:flutter/material.dart';
import 'package:homecheck_app/features/trusted_contacts/domain/entities/trusted_contact.dart';

class TrustedContactTile extends StatelessWidget {
  const TrustedContactTile({
    required this.contact,
    required this.onRemove,
    super.key,
  });

  final TrustedContact contact;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.person)),
      title: Text(contact.name),
      subtitle: Text(contact.phoneNumber),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline),
        onPressed: onRemove,
      ),
    );
  }
}
