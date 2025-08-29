import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:plie/model/event_model.dart';

class EventState {
  final List<Events> events;
  final List<Events> favouriteEvents;
  final bool isLoading;

  const EventState({
    this.events = const [],
    this.favouriteEvents = const [],
    this.isLoading = false,
  });

  EventState copyWith({
    List<Events>? events,
    List<Events>? favouriteEvents,
    bool? isLoading,
  }) {
    return EventState(
      events: events ?? this.events,
      favouriteEvents: favouriteEvents ?? this.favouriteEvents,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class EventNotifier extends StateNotifier<EventState> {
  EventNotifier() : super(const EventState());

  static const String baseUrl = "http://3.7.81.243/projects/plie-api/public/api";

  Future<void> loadEvents() async {
    state = state.copyWith(isLoading: true);
    try {
      final request = http.MultipartRequest(
        "POST",
        Uri.parse("$baseUrl/events-listing"),
      );

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);

      final eventsResponse = jsonDecode(response.body);

      if (eventsResponse['success'] == true) {
        final eventsList = (eventsResponse['data']['events'] as List)
            .map((e) => Events.fromJson(e))
            .toList();

        // because in response all records id's are same, which is not a good
        int i = 101;
        for (final e in eventsList) {
          i++;
          e.eventId = i;
        }

        // Build favourites from events
        final favourites = <Events>[
          for (final event in eventsList)
            if (event.isFavourite ?? false) event
        ];

        state = state.copyWith(
          events: eventsList,
          favouriteEvents: favourites,
          isLoading: false,
        );
      } else {
        debugPrint("Failed to load events: ${eventsResponse['message']}");
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      debugPrint("Error loading events: $e");
      state = state.copyWith(isLoading: false);
    }
  }

  void toggleFavourite(Events event) {
    final updatedEvents = state.events.map((e) {
      if (e.eventId == event.eventId) {
        e.isFavourite = !(e.isFavourite ?? false);
      }
      return e;
    }).toList();

    final updatedFavourites = <Events>[
      for (final e in updatedEvents)
        if (e.isFavourite ?? false) e
    ];

    state = state.copyWith(
      events: updatedEvents,
      favouriteEvents: updatedFavourites,
    );
  }
}

final eventProvider =
StateNotifierProvider<EventNotifier, EventState>((ref) => EventNotifier());
