import 'package:flutter/material.dart';
import '../../model/event_model.dart';
import 'tag_chip.dart';

class EventCard extends StatelessWidget {
  final Events event; // <-- changed to Events model
  final VoidCallback onFavouriteClick;

  const EventCard({
    super.key,
    required this.event,
    required this.onFavouriteClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black38,offset: Offset(1, 1),blurRadius: 2)]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Event Image
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: (event.eventProfileImg != null &&
                  event.eventProfileImg!.isNotEmpty)
                  ? Image.network(
                event.eventProfileImg!,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              )
                  : Container(
                width: 80,
                height: 80,
                color: Colors.grey.shade300,
                child: const Icon(Icons.image, color: Colors.white),
              ),
            ),
          ),
          // Event Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Padding(
                  padding: const EdgeInsets.only(top: 5.0,right: 5.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Text(
                          event.eventName ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                       InkWell(
                         onTap: () {
                         },
                         child: Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                                               ),
                       ),
                    ],
                  ),
                ),
                Text(
                  "${event.readableFromDate ?? ''}"
                      "${event.readableToDate != null && event.readableToDate!.isNotEmpty ? " - ${event.readableToDate}" : ""}",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                  ),
                ),

                const SizedBox(height: 4),

                // Price
                Text(
                  "€${event.eventPriceFrom ?? 0} - €${event.eventPriceTo ?? 0}",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade800,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5.0, bottom: 5.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: event.danceStyles != null
                              ? event.danceStyles!
                              .map((ds) => TagChip(label: ds.dsName ?? ""))
                              .toList()
                              : [],
                        ),
                      ),
                     InkWell(
                       onTap: onFavouriteClick,
                       child: Icon(
                         (event.isFavourite ?? false)
                             ? Icons.favorite
                             : Icons.favorite_border,
                         color: Colors.green,
                       ),
                     )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
