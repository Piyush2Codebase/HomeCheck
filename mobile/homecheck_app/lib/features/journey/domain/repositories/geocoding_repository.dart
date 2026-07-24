import 'package:homecheck_app/features/journey/domain/entities/geo_point.dart';

abstract interface class GeocodingRepository {
  Future<GeoPoint> resolveAddress(String address);
}
