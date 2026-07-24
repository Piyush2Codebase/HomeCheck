import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homecheck_app/features/journey/presentation/controllers/journey_controller.dart';

Future<void> showStartJourneySheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) => const _StartJourneySheet(),
  );
}

class _StartJourneySheet extends ConsumerStatefulWidget {
  const _StartJourneySheet();

  @override
  ConsumerState<_StartJourneySheet> createState() => _StartJourneySheetState();
}

class _StartJourneySheetState extends ConsumerState<_StartJourneySheet> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final journeyState = ref.watch(journeyControllerProvider);

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Start Journey', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Destination address',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: journeyState.isBusy
                  ? null
                  : () async {
                      final destination = _controller.text.trim();

                      if (destination.isEmpty) {
                        return;
                      }

                      await ref
                          .read(journeyControllerProvider.notifier)
                          .startJourney(destination);

                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    },
              child: journeyState.isBusy
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Start'),
            ),
          ),
        ],
      ),
    );
  }
}
