import 'package:flutter/material.dart';
import 'package:homecheck_app/features/journey/domain/entities/journey.dart';

class JourneyStatusCard extends StatelessWidget {
  const JourneyStatusCard({
    required this.journey,
    required this.onEndJourney,
    super.key,
  });

  final Journey journey;
  final VoidCallback onEndJourney;

  String get _phaseText {
    switch (journey.phase) {
      case JourneyPhase.headingToDestination:
        return 'Heading to ${journey.destinationLabel}';
      case JourneyPhase.headingHome:
        return 'Heading home';
      case JourneyPhase.completed:
        return 'Journey complete';
      case JourneyPhase.cancelled:
        return 'Journey ended';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Journey in progress',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(_phaseText),
            const SizedBox(height: 4),
            Text(
              'Started at ${TimeOfDay.fromDateTime(journey.startedAt).format(context)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: onEndJourney,
              child: const Text('End Journey'),
            ),
          ],
        ),
      ),
    );
  }
}
