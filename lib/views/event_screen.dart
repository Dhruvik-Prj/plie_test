import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plie/core/constants/fonts_constants.dart';
import '../core/components/event_card.dart';
import '../viewModel/event_notifier.dart';

class EventListScreen extends ConsumerStatefulWidget {
  const EventListScreen({super.key});

  @override
  ConsumerState<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends ConsumerState<EventListScreen> {
  @override
  void initState() {
    super.initState();
    // load once
    Future.microtask(() {
      ref.read(eventProvider.notifier).loadEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(eventProvider);
    final notifier = ref.read(eventProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello Renzo!",
                  style: AppTextStyles.robotoRegular.copyWith(fontSize: 35),
                ),
                Text(
                  "Are you ready to dance?",
                  style: AppTextStyles.robotoRegular
                      .copyWith(color: const Color(0xFF0F0F0F)),
                )
              ],
            ),
          ),
          state.isLoading
              ? const Expanded(
            child: Center(child: CircularProgressIndicator()),
          )
              : Expanded(
            child: ListView.builder(
              itemCount: state.events.length,
              itemBuilder: (context, index) {
                final event = state.events[index];
                return EventCard(
                  event: event,
                  onFavouriteClick: () {
                    notifier.toggleFavourite(event);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
