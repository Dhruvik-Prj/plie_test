import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plie/core/constants/fonts_constants.dart';
import '../core/components/event_card.dart';
import '../viewModel/event_notifier.dart';

class FavouriteScreen extends ConsumerWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(eventProvider);
    final notifier = ref.read(eventProvider.notifier);
    final favourites = state.favouriteEvents;

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
                  style: AppTextStyles.robotoRegular.copyWith(
                    color: const Color(0xFF0F0F0F),
                  ),
                ),
              ],
            ),
          ),
          state.isLoading
              ? const Expanded(child: Center(child: CircularProgressIndicator()))
              : Expanded(
            child: favourites.isEmpty
                ? const Center(child: Text("No favourites yet"))
                : ListView.builder(
              itemCount: favourites.length,
              itemBuilder: (context, index) {
                return EventCard(
                  event: favourites[index],
                  onFavouriteClick: () {
                    notifier.toggleFavourite(favourites[index]);
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
