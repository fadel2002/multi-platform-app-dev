import 'package:belajar_fundamental_aplikasi_flutter/screen/detail/widget/restaurant_detail_body_widget.dart';
import 'package:flutter/material.dart';

import '../../../data/model/restaurant.dart';
import '../../../utils/enums.dart';
import '../../../utils/image_helper.dart';
import 'restaurant_detail_header_widget.dart';

class RestaurantDetailScreenWidget extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailScreenWidget({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 250.0,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Hero(
              tag: 'hero-image-${restaurant.id}',
              child: Image.network(
                ImageHelper.getImageUrl(restaurant.pictureId, ImageSize.large),
                fit: BoxFit.cover,
              ),
            ),
          ),
          leading: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RestaurantDetailHeaderWidget(restaurant: restaurant),
                    RestaurantDetailBodyWidget(restaurant: restaurant),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true, // Ensures the list takes only the space it needs
                      physics: NeverScrollableScrollPhysics(), // Prevents nested scrolling
                      itemCount: restaurant.customerReviews?.length ?? 0,
                      itemBuilder: (context, index) {
                        final review = restaurant.customerReviews?[index];
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

