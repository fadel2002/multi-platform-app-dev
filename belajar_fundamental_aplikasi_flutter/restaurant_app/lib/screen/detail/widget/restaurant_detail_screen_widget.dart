import 'package:belajar_fundamental_aplikasi_flutter/provider/restaurant/restaurant_post_review_provider.dart';
import 'package:belajar_fundamental_aplikasi_flutter/screen/detail/widget/restaurant_detail_footer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/model/restaurant.dart';
import '../../../provider/restaurant/restaurant_search_provider.dart';
import '../../../utils/enums.dart';
import '../../../utils/image_helper.dart';
import 'restaurant_detail_body_widget.dart';
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
                    RestaurantDetailFooterWidget(customerReviews: restaurant.customerReviews, restaurantId: restaurant.id),
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

