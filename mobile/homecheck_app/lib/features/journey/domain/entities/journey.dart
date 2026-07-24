import 'package:homecheck_app/features/journey/domain/entities/geo_point.dart';

enum JourneyPhase { headingToDestination, headingHome, completed, cancelled }

class Journey {
  const Journey({
    required this.id,
    required this.destinationLabel,
    required this.destinationLocation,
    required this.homeLocation,
    required this.startedAt,
    required this.phase,
    this.leftHomeAt,
    this.arrivedDestinationAt,
    this.endedAt,
  });

  factory Journey.fromJson(Map<String, dynamic> json) {
    return Journey(
      id: json['id'] as String,
      destinationLabel: json['destinationLabel'] as String,
      destinationLocation: GeoPoint.fromJson(
        json['destinationLocation'] as Map<String, dynamic>,
      ),
      homeLocation: GeoPoint.fromJson(
        json['homeLocation'] as Map<String, dynamic>,
      ),
      startedAt: DateTime.parse(json['startedAt'] as String),
      phase: JourneyPhase.values.byName(json['phase'] as String),
      leftHomeAt: json['leftHomeAt'] == null
          ? null
          : DateTime.parse(json['leftHomeAt'] as String),
      arrivedDestinationAt: json['arrivedDestinationAt'] == null
          ? null
          : DateTime.parse(json['arrivedDestinationAt'] as String),
      endedAt: json['endedAt'] == null
          ? null
          : DateTime.parse(json['endedAt'] as String),
    );
  }

  final String id;
  final String destinationLabel;
  final GeoPoint destinationLocation;
  final GeoPoint homeLocation;
  final DateTime startedAt;
  final JourneyPhase phase;
  final DateTime? leftHomeAt;
  final DateTime? arrivedDestinationAt;
  final DateTime? endedAt;

  bool get isActive =>
      phase == JourneyPhase.headingToDestination ||
      phase == JourneyPhase.headingHome;

  Journey copyWith({
    JourneyPhase? phase,
    DateTime? leftHomeAt,
    DateTime? arrivedDestinationAt,
    DateTime? endedAt,
  }) {
    return Journey(
      id: id,
      destinationLabel: destinationLabel,
      destinationLocation: destinationLocation,
      homeLocation: homeLocation,
      startedAt: startedAt,
      phase: phase ?? this.phase,
      leftHomeAt: leftHomeAt ?? this.leftHomeAt,
      arrivedDestinationAt: arrivedDestinationAt ?? this.arrivedDestinationAt,
      endedAt: endedAt ?? this.endedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'destinationLabel': destinationLabel,
      'destinationLocation': destinationLocation.toJson(),
      'homeLocation': homeLocation.toJson(),
      'startedAt': startedAt.toIso8601String(),
      'phase': phase.name,
      'leftHomeAt': leftHomeAt?.toIso8601String(),
      'arrivedDestinationAt': arrivedDestinationAt?.toIso8601String(),
      'endedAt': endedAt?.toIso8601String(),
    };
  }
}
