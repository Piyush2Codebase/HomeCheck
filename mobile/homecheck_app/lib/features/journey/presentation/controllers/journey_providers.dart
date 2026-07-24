import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homecheck_app/features/journey/data/repositories/geocoding_address_repository.dart';
import 'package:homecheck_app/features/journey/data/repositories/geolocator_location_repository.dart';
import 'package:homecheck_app/features/journey/data/repositories/local_journey_repository.dart';
import 'package:homecheck_app/features/journey/domain/repositories/geocoding_repository.dart';
import 'package:homecheck_app/features/journey/domain/repositories/journey_repository.dart';
import 'package:homecheck_app/features/journey/domain/repositories/location_repository.dart';
import 'package:homecheck_app/features/journey/domain/usecases/get_home_location.dart';
import 'package:homecheck_app/features/journey/domain/usecases/get_recent_journeys.dart';

final journeyRepositoryProvider = Provider<JourneyRepository>((ref) {
  return LocalJourneyRepository();
});

final locationRepositoryProvider = Provider<LocationRepository>((ref) {
  return GeolocatorLocationRepository();
});

final geocodingRepositoryProvider = Provider<GeocodingRepository>((ref) {
  return GeocodingAddressRepository();
});

final getHomeLocationProvider = Provider<GetHomeLocation>((ref) {
  return GetHomeLocation(ref.read(journeyRepositoryProvider));
});

final getRecentJourneysProvider = Provider<GetRecentJourneys>((ref) {
  return GetRecentJourneys(ref.read(journeyRepositoryProvider));
});
