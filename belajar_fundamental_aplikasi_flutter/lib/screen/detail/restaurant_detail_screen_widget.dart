import 'package:belajar_fundamental_aplikasi_flutter/data/model/restaurant.dart';
import 'package:belajar_fundamental_aplikasi_flutter/utils/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/detail/favorite_icon_provider.dart';
import '../../provider/detail/restaurant_detail_provider.dart';
import '../../static/restaurant_detail_state.dart';
import 'favorite_icon_widget.dart';

class RestaurantDetailScreenWidget extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailScreenWidget({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    int fullStars = restaurant.rating.floor();
    double partialStar = restaurant.rating - fullStars;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                ImageHelper.getImageUrl(restaurant.pictureId, ImageSize.large),
                fit: BoxFit.cover,
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
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              spacing: 6,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      restaurant.name,
                                      style: Theme.of(context).textTheme.headlineLarge,
                                    ),
                                    ChangeNotifierProvider(
                                      create: (context) => FavoriteIconProvider(),
                                      child: Consumer<RestaurantDetailProvider>(
                                        builder: (context, value, child) {
                                          return switch (value.resultState) {
                                            RestaurantDetailLoadedState(data: var restaurant) =>
                                                FavoriteIconWidget(restaurant: restaurant),
                                            _ => const SizedBox(),
                                          };
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  spacing: 6,
                                  children: [
                                    Icon(Icons.pin_drop, color: Theme.of(context).colorScheme.secondary),
                                    Text(
                                      "${restaurant.address}, ${restaurant.city}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                Row(
                                  spacing: 6,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: List.generate(5, (index) {
                                        if (index < fullStars) {
                                          return  Icon(Icons.star, color: Theme.of(context).colorScheme.secondary);
                                        } else if (index == fullStars) {
                                          if (partialStar > 0) {
                                            return Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                Icon(Icons.star_border, color: Theme.of(context).colorScheme.secondary),
                                                ClipRect(
                                                  child: Align(
                                                    alignment: Alignment.centerLeft,
                                                    widthFactor: ((partialStar/10)*4) + 0.3,
                                                    child: Icon(Icons.star, color: Theme.of(context).colorScheme.secondary),
                                                  ),
                                                ),
                                              ],
                                            );
                                          } else {
                                            return Icon(Icons.star_border, color: Theme.of(context).colorScheme.secondary);
                                          }
                                        } else {
                                          return Icon(Icons.star_border, color: Theme.of(context).colorScheme.secondary);
                                        }
                                      }),
                                    ),
                                    Text(
                                      restaurant.rating.toString(),
                                      style: Theme.of(context).textTheme.labelLarge,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        restaurant.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
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
