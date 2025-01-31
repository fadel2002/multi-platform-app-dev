import 'package:flutter/material.dart';

import '../../../data/model/restaurant.dart';

class RestaurantDetailBodyWidget extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailBodyWidget({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
      ],
    );
  }
}
