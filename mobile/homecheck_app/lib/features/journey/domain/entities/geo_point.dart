class GeoPoint {
  const GeoPoint({required this.latitude, required this.longitude});

  factory GeoPoint.fromJson(Map<String, dynamic> json) {
    return GeoPoint(
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
    );
  }

  final double latitude;
  final double longitude;

  Map<String, dynamic> toJson() {
    return {'latitude': latitude, 'longitude': longitude};
  }
}
