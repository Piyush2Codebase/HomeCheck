import 'package:homecheck_app/features/journey/domain/entities/journey.dart';
import 'package:homecheck_app/features/journey/domain/repositories/journey_repository.dart';

class GetRecentJourneys {
  const GetRecentJourneys(this._repository);

  final JourneyRepository _repository;

  Future<List<Journey>> call({int limit = 10}) {
    return _repository.getRecentJourneys(limit: limit);
  }
}
