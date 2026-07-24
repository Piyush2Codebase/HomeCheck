import 'package:geolocator/geolocator.dart';
import 'package:homecheck_app/features/journey/domain/entities/geo_point.dart';
import 'package:homecheck_app/features/journey/domain/repositories/location_repository.dart';

class GeolocatorLocationRepository implements LocationRepository {
  static const _locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 15,
  );

  @override
  Future<bool> ensurePermission() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      return false;
    }

    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  @override
  Future<GeoPoint> getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition(
      locationSettings: _locationSettings,
    );

    return GeoPoint(latitude: position.latitude, longitude: position.longitude);
  }

  @override
  Stream<GeoPoint> watchPosition() {
    return Geolocator.getPositionStream(locationSettings: _locationSettings).map(
      (position) =>
          GeoPoint(latitude: position.latitude, longitude: position.longitude),
    );
  }

  @override
  double distanceBetween(GeoPoint a, GeoPoint b) {
    return Geolocator.distanceBetween(
      a.latitude,
      a.longitude,
      b.latitude,
      b.longitude,
    );
  }
}
