import 'package:homecheck_app/features/journey/domain/entities/geo_point.dart';

abstract interface class LocationRepository {
  Future<bool> ensurePermission();

  Future<GeoPoint> getCurrentPosition();

  Stream<GeoPoint> watchPosition();

  double distanceBetween(GeoPoint a, GeoPoint b);
}
