import 'package:flutter/material.dart';

import '../../../data/model/restaurant.dart';

class RestaurantReviewListWidget extends StatelessWidget {
  final List<CustomerReview>? customerReviews;
  const RestaurantReviewListWidget({super.key, required this.customerReviews});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: customerReviews?.length ?? 0,
      itemBuilder: (context, index) {
        final review = customerReviews?[(customerReviews?.length ?? 0)-1-index];
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 12,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 6,
                        ),
                        child: Icon(
                          Icons.person,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review?.name ?? "",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            review?.date ?? "",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Text(
                  review?.review ?? "",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
