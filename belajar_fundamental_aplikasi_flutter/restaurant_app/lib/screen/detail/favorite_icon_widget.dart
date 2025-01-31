import 'package:belajar_fundamental_aplikasi_flutter/data/model/restaurant.dart';
import 'package:belajar_fundamental_aplikasi_flutter/provider/detail/favorite_icon_provider.dart';
import 'package:belajar_fundamental_aplikasi_flutter/provider/detail/favorite_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


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
  @override
  void initState() {
    final favoriteListProvider = context.read<FavoriteListProvider>();
    final favoriteIconProvider = context.read<FavoriteIconProvider>();

    Future.microtask(() {
      final favoriteInList = favoriteListProvider.checkItemBookmark(widget.restaurant);
      favoriteIconProvider.isFavorite  = favoriteInList;
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        final favoriteListProvider = context.read<FavoriteListProvider>();
        final favoriteIconProvider = context.read<FavoriteIconProvider>();
        final isFavorite = favoriteIconProvider.isFavorite;

        if (!isFavorite) {
          favoriteListProvider.addBookmark(widget.restaurant);
        } else {
          favoriteListProvider.removeBookmark(widget.restaurant);
        }
        favoriteIconProvider.isFavorite = !isFavorite;
      },
      icon: Icon(
        context.watch<FavoriteIconProvider>().isFavorite ?
        Icons.bookmark : Icons.bookmark_outline,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}