import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/model/restaurant.dart';
import '../../../provider/detail/favorite_icon_provider.dart';
import '../../../provider/favorite/local_database_provider.dart';

class FavoriteIconWidget extends StatefulWidget {
  final Restaurant restaurant;
  const FavoriteIconWidget({
    super.key,
    required this.restaurant,
  });

  @override
  State<FavoriteIconWidget> createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget> {
  late LocalDatabaseProvider localDatabaseProvider;
  late FavoriteIconProvider favoriteIconProvider;

  @override
  void initState() {
    localDatabaseProvider = context.read<LocalDatabaseProvider>();
    favoriteIconProvider = context.read<FavoriteIconProvider>();

    Future.microtask(() async {
      await localDatabaseProvider.loadRestaurantById(widget.restaurant.id);
      final favoriteInList = localDatabaseProvider.checkItemFavorite(widget.restaurant.id);
      favoriteIconProvider.isFavorite  = favoriteInList;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        final isFavorite = favoriteIconProvider.isFavorite;

        if (!isFavorite) {
          localDatabaseProvider.saveRestaurant(widget.restaurant);
        } else {
          localDatabaseProvider.removeRestaurantById(widget.restaurant.id);
        }
        favoriteIconProvider.isFavorite = !isFavorite;
      },
      icon: Icon(
        size: 30,
        context.watch<FavoriteIconProvider>().isFavorite ?
          Icons.favorite : Icons.favorite_outline,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}