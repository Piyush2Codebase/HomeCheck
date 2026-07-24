import 'package:homecheck_app/features/journey/domain/entities/geo_point.dart';
import 'package:homecheck_app/features/journey/domain/entities/journey.dart';

abstract interface class JourneyRepository {
  Future<GeoPoint?> getHomeLocation();

  Future<void> saveHomeLocation(GeoPoint location);

  Future<Journey?> getActiveJourney();

  Future<List<Journey>> getRecentJourneys({int limit = 10});

  Future<void> saveJourney(Journey journey);
}
