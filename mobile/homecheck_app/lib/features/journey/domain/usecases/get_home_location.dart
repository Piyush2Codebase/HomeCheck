import 'package:homecheck_app/features/journey/domain/entities/geo_point.dart';
import 'package:homecheck_app/features/journey/domain/repositories/journey_repository.dart';

class GetHomeLocation {
  const GetHomeLocation(this._repository);

  final JourneyRepository _repository;

  Future<GeoPoint?> call() => _repository.getHomeLocation();
}
