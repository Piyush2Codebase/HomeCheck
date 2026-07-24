class TrustedContact {
  const TrustedContact({
    required this.id,
    required this.name,
    required this.phoneNumber,
  });

  factory TrustedContact.fromJson(Map<String, dynamic> json) {
    return TrustedContact(
      id: json['id'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );
  }

  final String id;
  final String name;
  final String phoneNumber;

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'phoneNumber': phoneNumber};
  }
}
