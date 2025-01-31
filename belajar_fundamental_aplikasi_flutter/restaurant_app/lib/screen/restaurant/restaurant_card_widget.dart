import 'package:flutter/material.dart';

import '../../data/model/restaurant.dart';
import '../../utils/image_helper.dart';

class RestaurantCardWidget extends StatelessWidget {
  final Restaurant restaurant;
  final Function() onTap;

  const RestaurantCardWidget({
    super.key,
    required this.restaurant,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    int fullStars = restaurant.rating.floor();
    double partialStar = restaurant.rating - fullStars;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Row(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 80,
                minHeight: 80,
                maxWidth: 120,
                minWidth: 120,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Hero(
                  tag: 'hero-image',
                  child: Image.network(
                    ImageHelper.getImageUrl(restaurant.pictureId, ImageSize.small),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: 6,
                children: [
                  Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Row(
                    spacing: 4,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          if (index < fullStars) {
                            return Icon(Icons.star, color: Theme.of(context).colorScheme.primary);
                          } else if (index == fullStars) {
                            if (partialStar > 0) {
                              return Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Icon(Icons.star_border, color: Theme.of(context).colorScheme.primary),
                                  ClipRect(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: ((partialStar/10)*4) + 0.3,
                                      child: Icon(Icons.star, color: Theme.of(context).colorScheme.primary),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Icon(Icons.star_border, color: Theme.of(context).colorScheme.primary);
                            }
                          } else {
                            return Icon(Icons.star_border, color: Theme.of(context).colorScheme.primary);
                          }
                        }),
                      ),
                      Expanded(
                        child: Text(
                          restaurant.rating.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 4,
                    children: [
                      Icon(
                        Icons.pin_drop,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      Expanded(
                        child: Text(
                          restaurant.city,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
