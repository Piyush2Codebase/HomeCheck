import 'package:homecheck_app/features/journey/domain/entities/geo_point.dart';
import 'package:homecheck_app/features/journey/domain/entities/journey.dart';

class JourneyState {
  const JourneyState({
    this.homeLocation,
    this.activeJourney,
    this.recentJourneys = const [],
    this.isBusy = false,
    this.errorMessage,
  });

  final GeoPoint? homeLocation;
  final Journey? activeJourney;
  final List<Journey> recentJourneys;
  final bool isBusy;
  final String? errorMessage;

  JourneyState copyWith({
    GeoPoint? homeLocation,
    Journey? activeJourney,
    bool clearActiveJourney = false,
    List<Journey>? recentJourneys,
    bool? isBusy,
    String? errorMessage,
    bool clearError = false,
  }) {
    return JourneyState(
      homeLocation: homeLocation ?? this.homeLocation,
      activeJourney: clearActiveJourney
          ? null
          : activeJourney ?? this.activeJourney,
      recentJourneys: recentJourneys ?? this.recentJourneys,
      isBusy: isBusy ?? this.isBusy,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
