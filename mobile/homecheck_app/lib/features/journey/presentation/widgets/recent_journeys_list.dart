import 'package:flutter/material.dart';
import 'package:homecheck_app/features/journey/domain/entities/journey.dart';

class RecentJourneysList extends StatelessWidget {
  const RecentJourneysList({required this.journeys, super.key});

  final List<Journey> journeys;

  String _statusText(Journey journey) {
    switch (journey.phase) {
      case JourneyPhase.completed:
        return 'Completed';
      case JourneyPhase.cancelled:
        return 'Ended manually';
      case JourneyPhase.headingToDestination:
      case JourneyPhase.headingHome:
        return 'In progress';
    }
  }

  IconData _statusIcon(Journey journey) {
    switch (journey.phase) {
      case JourneyPhase.completed:
        return Icons.check_circle;
      case JourneyPhase.cancelled:
        return Icons.cancel;
      case JourneyPhase.headingToDestination:
      case JourneyPhase.headingHome:
        return Icons.directions_walk;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (journeys.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Text('No journeys yet'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recent Journeys', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        ...journeys.map(
          (journey) => ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(_statusIcon(journey)),
            title: Text(journey.destinationLabel),
            subtitle: Text(_statusText(journey)),
            trailing: Text(
              '${journey.startedAt.hour.toString().padLeft(2, '0')}:${journey.startedAt.minute.toString().padLeft(2, '0')}',
            ),
          ),
        ),
      ],
    );
  }
}
