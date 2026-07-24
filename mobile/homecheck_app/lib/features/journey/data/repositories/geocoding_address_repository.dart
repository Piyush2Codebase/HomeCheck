import 'package:geocoding/geocoding.dart';
import 'package:homecheck_app/features/journey/domain/entities/address_not_found_exception.dart';
import 'package:homecheck_app/features/journey/domain/entities/geo_point.dart';
import 'package:homecheck_app/features/journey/domain/repositories/geocoding_repository.dart';

class GeocodingAddressRepository implements GeocodingRepository {
  final _geocoding = Geocoding();

  @override
  Future<GeoPoint> resolveAddress(String address) async {
    List<Location> locations;

    try {
      locations = await _geocoding.locationFromAddress(address);
    } catch (_) {
      throw AddressNotFoundException(address);
    }

    if (locations.isEmpty) {
      throw AddressNotFoundException(address);
    }

    final location = locations.first;

    return GeoPoint(latitude: location.latitude, longitude: location.longitude);
  }
}
