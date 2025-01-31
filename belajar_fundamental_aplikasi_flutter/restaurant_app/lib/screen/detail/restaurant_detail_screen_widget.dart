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
              background: Hero(
                tag: 'hero-image',
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
                      Divider(
                        color: Theme.of(context).colorScheme.secondary, // Color of the line
                        height: 2, // Height of the line
                        thickness: 1, // Thickness of the line
                      ),
                      Text(
                        "Category",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 6,
                        children: List.generate(restaurant.categories?.length ?? 0, (index) {
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surfaceContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                                restaurant.categories?[index].name ?? "",
                                style: Theme.of(context).textTheme.bodyLarge
                            ),
                          );
                        }),
                      ),
                      Text(
                        "Description",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        restaurant.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        "Menus",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        "Foods",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        alignment: WrapAlignment.start,
                        children: List.generate(restaurant.menus?.foods.length ?? 0, (index) {
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surfaceContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              restaurant.menus?.foods[index].name ?? "",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          );
                        }),
                      ),
                      Text(
                        "Drinks",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        alignment: WrapAlignment.start,
                        children: List.generate(restaurant.menus?.drinks.length ?? 0, (index) {
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surfaceContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              restaurant.menus?.drinks[index].name ?? "",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          );
                        }),
                      ),
                      Divider(
                        color: Theme.of(context).colorScheme.secondary, // Color of the line
                        height: 2, // Height of the line
                        thickness: 1, // Thickness of the line
                      ),
                      Text(
                        "Reviews",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      ListView.builder(
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
                                    overflow: TextOverflow.ellipsis,
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
      ),
    );
  }
}
