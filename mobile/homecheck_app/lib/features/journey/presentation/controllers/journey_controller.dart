import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homecheck_app/core/services/notification_service.dart';
import 'package:homecheck_app/features/journey/domain/entities/address_not_found_exception.dart';
import 'package:homecheck_app/features/journey/domain/entities/geo_point.dart';
import 'package:homecheck_app/features/journey/domain/entities/journey.dart';
import 'package:homecheck_app/features/journey/presentation/controllers/journey_providers.dart';
import 'package:homecheck_app/features/journey/presentation/controllers/journey_state.dart';

const _leftHomeThresholdMeters = 150.0;
const _destinationArrivalThresholdMeters = 100.0;
const _returnedHomeThresholdMeters = 100.0;

class JourneyController extends Notifier<JourneyState> {
  StreamSubscription<GeoPoint>? _positionSubscription;

  @override
  JourneyState build() {
    ref.onDispose(() {
      _positionSubscription?.cancel();
    });

    Future.microtask(_loadInitialData);

    return const JourneyState();
  }

  Future<void> _loadInitialData() async {
    final homeLocation = await ref.read(getHomeLocationProvider)();
    final recentJourneys = await ref.read(getRecentJourneysProvider)();
    final activeJourney = await ref
        .read(journeyRepositoryProvider)
        .getActiveJourney();

    state = state.copyWith(
      homeLocation: homeLocation,
      recentJourneys: recentJourneys,
      activeJourney: activeJourney,
    );

    if (activeJourney != null) {
      _startWatchingPosition();
    }
  }

  Future<void> setHomeLocationFromCurrentPosition() async {
    state = state.copyWith(isBusy: true, clearError: true);

    final locationRepository = ref.read(locationRepositoryProvider);
    final hasPermission = await locationRepository.ensurePermission();

    if (!hasPermission) {
      state = state.copyWith(
        isBusy: false,
        errorMessage:
            'Location permission is required to set your home location.',
      );

      return;
    }

    try {
      final position = await locationRepository.getCurrentPosition();
      await ref.read(journeyRepositoryProvider).saveHomeLocation(position);

      state = state.copyWith(homeLocation: position, isBusy: false);
    } catch (_) {
      state = state.copyWith(
        isBusy: false,
        errorMessage: 'Could not get your current location.',
      );
    }
  }

  Future<void> startJourney(String destinationAddress) async {
    final homeLocation = state.homeLocation;

    if (homeLocation == null || state.activeJourney != null) {
      return;
    }

    state = state.copyWith(isBusy: true, clearError: true);

    final locationRepository = ref.read(locationRepositoryProvider);
    final hasPermission = await locationRepository.ensurePermission();

    if (!hasPermission) {
      state = state.copyWith(
        isBusy: false,
        errorMessage: 'Location permission is required to start a journey.',
      );

      return;
    }

    GeoPoint destinationLocation;

    try {
      destinationLocation = await ref
          .read(geocodingRepositoryProvider)
          .resolveAddress(destinationAddress);
    } on AddressNotFoundException catch (e) {
      state = state.copyWith(isBusy: false, errorMessage: e.toString());

      return;
    } catch (_) {
      state = state.copyWith(
        isBusy: false,
        errorMessage: 'Could not find that destination.',
      );

      return;
    }

    final journey = Journey(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      destinationLabel: destinationAddress,
      destinationLocation: destinationLocation,
      homeLocation: homeLocation,
      startedAt: DateTime.now(),
      phase: JourneyPhase.headingToDestination,
    );

    await ref.read(journeyRepositoryProvider).saveJourney(journey);

    state = state.copyWith(activeJourney: journey, isBusy: false);

    _startWatchingPosition();
  }

  Future<void> endJourneyManually() async {
    final journey = state.activeJourney;

    if (journey == null) {
      return;
    }

    await _positionSubscription?.cancel();
    _positionSubscription = null;

    final updated = journey.copyWith(
      phase: JourneyPhase.cancelled,
      endedAt: DateTime.now(),
    );

    await ref.read(journeyRepositoryProvider).saveJourney(updated);

    final recentJourneys = await ref.read(getRecentJourneysProvider)();

    state = state.copyWith(
      clearActiveJourney: true,
      recentJourneys: recentJourneys,
    );
  }

  void _startWatchingPosition() {
    _positionSubscription?.cancel();

    final locationRepository = ref.read(locationRepositoryProvider);

    _positionSubscription = locationRepository.watchPosition().listen(
      _handlePositionUpdate,
    );
  }

  Future<void> _handlePositionUpdate(GeoPoint position) async {
    final journey = state.activeJourney;

    if (journey == null) {
      return;
    }

    final locationRepository = ref.read(locationRepositoryProvider);
    final notificationService = ref.read(notificationServiceProvider);
    final journeyRepository = ref.read(journeyRepositoryProvider);

    if (journey.phase == JourneyPhase.headingToDestination) {
      var current = journey;

      final distanceToHome = locationRepository.distanceBetween(
        position,
        current.homeLocation,
      );

      if (current.leftHomeAt == null &&
          distanceToHome > _leftHomeThresholdMeters) {
        current = current.copyWith(leftHomeAt: DateTime.now());
        await journeyRepository.saveJourney(current);
        state = state.copyWith(activeJourney: current);

        await notificationService.showJourneyEvent(
          id: 1,
          title: 'You left home',
          body: 'Heading to ${current.destinationLabel}',
        );
      }

      final distanceToDestination = locationRepository.distanceBetween(
        position,
        current.destinationLocation,
      );

      if (distanceToDestination <= _destinationArrivalThresholdMeters) {
        final updated = current.copyWith(
          phase: JourneyPhase.headingHome,
          arrivedDestinationAt: DateTime.now(),
        );
        await journeyRepository.saveJourney(updated);
        state = state.copyWith(activeJourney: updated);

        await notificationService.showJourneyEvent(
          id: 2,
          title: "You've arrived",
          body: "You're at ${current.destinationLabel}",
        );
      }

      return;
    }

    if (journey.phase == JourneyPhase.headingHome) {
      final distanceToHome = locationRepository.distanceBetween(
        position,
        journey.homeLocation,
      );

      if (distanceToHome <= _returnedHomeThresholdMeters) {
        final updated = journey.copyWith(
          phase: JourneyPhase.completed,
          endedAt: DateTime.now(),
        );
        await journeyRepository.saveJourney(updated);

        await _positionSubscription?.cancel();
        _positionSubscription = null;

        final recentJourneys = await ref.read(getRecentJourneysProvider)();

        state = state.copyWith(
          clearActiveJourney: true,
          recentJourneys: recentJourneys,
        );

        await notificationService.showJourneyEvent(
          id: 3,
          title: "You're home",
          body: 'Journey to ${journey.destinationLabel} complete',
        );
      }
    }
  }
}

final journeyControllerProvider =
    NotifierProvider<JourneyController, JourneyState>(JourneyController.new);
