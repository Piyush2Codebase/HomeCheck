class AddressNotFoundException implements Exception {
  const AddressNotFoundException(this.address);

  final String address;

  @override
  String toString() => 'Could not find a location for "$address"';
}
