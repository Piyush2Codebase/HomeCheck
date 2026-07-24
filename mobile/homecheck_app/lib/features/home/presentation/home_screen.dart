import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:homecheck_app/app/routes/app_routes.dart';
import 'package:homecheck_app/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:homecheck_app/features/journey/domain/entities/geo_point.dart';
import 'package:homecheck_app/features/journey/presentation/controllers/journey_controller.dart';
import 'package:homecheck_app/features/journey/presentation/widgets/journey_status_card.dart';
import 'package:homecheck_app/features/journey/presentation/widgets/recent_journeys_list.dart';
import 'package:homecheck_app/features/journey/presentation/widgets/start_journey_sheet.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final journeyState = ref.watch(journeyControllerProvider);
    final user = authState.user;

    ref.listen(journeyControllerProvider, (previous, next) {
      if (next.errorMessage != null &&
          next.errorMessage != previous?.errorMessage) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.errorMessage!)));
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${user?.displayName ?? 'User'}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.contacts),
            tooltip: 'Trusted Contacts',
            onPressed: () {
              context.push(AppRoutes.trustedContacts);
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sign Out',
            onPressed: () {
              ref.read(authControllerProvider.notifier).signOut();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _HomeLocationCard(
              homeLocation: journeyState.homeLocation,
              isBusy: journeyState.isBusy,
              onSetHomeLocation: () {
                ref
                    .read(journeyControllerProvider.notifier)
                    .setHomeLocationFromCurrentPosition();
              },
            ),
            const SizedBox(height: 16),
            if (journeyState.activeJourney != null)
              JourneyStatusCard(
                journey: journeyState.activeJourney!,
                onEndJourney: () {
                  ref.read(journeyControllerProvider.notifier).endJourneyManually();
                },
              )
            else
              FilledButton.icon(
                onPressed: journeyState.homeLocation == null
                    ? null
                    : () => showStartJourneySheet(context),
                icon: const Icon(Icons.directions_run),
                label: const Text('Start Journey'),
              ),
            const SizedBox(height: 24),
            RecentJourneysList(journeys: journeyState.recentJourneys),
          ],
        ),
      ),
    );
  }
}

class _HomeLocationCard extends StatelessWidget {
  const _HomeLocationCard({
    required this.homeLocation,
    required this.isBusy,
    required this.onSetHomeLocation,
  });

  final GeoPoint? homeLocation;
  final bool isBusy;
  final VoidCallback onSetHomeLocation;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              homeLocation == null ? Icons.home_outlined : Icons.home,
              color: homeLocation == null ? null : Colors.green,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                homeLocation == null
                    ? 'Home location not set'
                    : 'Home location set',
              ),
            ),
            if (homeLocation == null)
              TextButton(
                onPressed: isBusy ? null : onSetHomeLocation,
                child: isBusy
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Use Current Location'),
              ),
          ],
        ),
      ),
    );
  }
}
