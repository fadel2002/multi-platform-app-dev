import 'package:belajar_fundamental_aplikasi_flutter/provider/detail/favorite_list_provider.dart';
import 'package:belajar_fundamental_aplikasi_flutter/provider/favorite/local_database_provider.dart';
import 'package:belajar_fundamental_aplikasi_flutter/screen/restaurant/restaurant_card_widget.dart';
import 'package:belajar_fundamental_aplikasi_flutter/static/navigation_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    Future.microtask(() async {
      await context.read<LocalDatabaseProvider>().loadAllRestaurant();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Restaurant List"),
      ),
      body: Consumer<LocalDatabaseProvider>(
        builder: (context, value, child){
          final favoriteList = value.restaurantList ?? [];
          if (favoriteList.isEmpty){
            return Center(child: Text("No favorite restaurants added yet", style: Theme.of(context).textTheme.bodyLarge));
          }
          return ListView.builder(
              itemCount: favoriteList.length,
              itemBuilder: (context, index) {
                final favorite = favoriteList[index];
                return RestaurantCardWidget(
                    restaurant: favorite,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        NavigationRoute.detailRoute.name,
                        arguments: favorite.id
                      );
                    }
                );
              }
          );
        }
      )
    );
  }
}
