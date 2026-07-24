import 'package:homecheck_app/features/trusted_contacts/domain/entities/trusted_contact.dart';

class TrustedContactsState {
  const TrustedContactsState({
    this.contacts = const [],
    this.isBusy = false,
    this.errorMessage,
  });

  final List<TrustedContact> contacts;
  final bool isBusy;
  final String? errorMessage;

  TrustedContactsState copyWith({
    List<TrustedContact>? contacts,
    bool? isBusy,
    String? errorMessage,
    bool clearError = false,
  }) {
    return TrustedContactsState(
      contacts: contacts ?? this.contacts,
      isBusy: isBusy ?? this.isBusy,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
