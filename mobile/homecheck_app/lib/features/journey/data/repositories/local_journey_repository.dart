import 'dart:convert';

import 'package:homecheck_app/features/journey/domain/entities/geo_point.dart';
import 'package:homecheck_app/features/journey/domain/entities/journey.dart';
import 'package:homecheck_app/features/journey/domain/repositories/journey_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalJourneyRepository implements JourneyRepository {
  static const _homeLocationKey = 'journey.home_location';
  static const _journeysKey = 'journey.journeys';

  @override
  Future<GeoPoint?> getHomeLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_homeLocationKey);

    if (raw == null) {
      return null;
    }

    return GeoPoint.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  @override
  Future<void> saveHomeLocation(GeoPoint location) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_homeLocationKey, jsonEncode(location.toJson()));
  }

  @override
  Future<Journey?> getActiveJourney() async {
    final journeys = await _loadJourneys();

    for (final journey in journeys.reversed) {
      if (journey.isActive) {
        return journey;
      }
    }

    return null;
  }

  @override
  Future<List<Journey>> getRecentJourneys({int limit = 10}) async {
    final journeys = await _loadJourneys();
    final sorted = journeys.toList()
      ..sort((a, b) => b.startedAt.compareTo(a.startedAt));

    return sorted.take(limit).toList();
  }

  @override
  Future<void> saveJourney(Journey journey) async {
    final journeys = await _loadJourneys();
    final index = journeys.indexWhere((existing) => existing.id == journey.id);

    if (index == -1) {
      journeys.add(journey);
    } else {
      journeys[index] = journey;
    }

    await _persistJourneys(journeys);
  }

  Future<List<Journey>> _loadJourneys() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_journeysKey);

    if (raw == null) {
      return [];
    }

    final decoded = jsonDecode(raw) as List<dynamic>;

    return decoded
        .map((entry) => Journey.fromJson(entry as Map<String, dynamic>))
        .toList();
  }

  Future<void> _persistJourneys(List<Journey> journeys) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(journeys.map((j) => j.toJson()).toList());
    await prefs.setString(_journeysKey, encoded);
  }
}
