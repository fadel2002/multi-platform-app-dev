import 'package:belajar_fundamental_aplikasi_flutter/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../provider/favorite/local_database_provider.dart';
import '../../static/navigation_route.dart';
import '../restaurant/restaurant_card_widget.dart';

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
          if (favoriteList.isEmpty || value.isError == ErrorType.noInternetConnection.name){
            return Center(
              child: Column(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                      favoriteList.isEmpty
                          ? "No favorite restaurants added yet."
                          : "No internet connection found. Please check your connection and try again.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  (value.isError == ErrorType.noInternetConnection.name && favoriteList.isNotEmpty) ? ElevatedButton(
                    onPressed: () {
                      context.read<LocalDatabaseProvider>().loadAllRestaurant();
                    },
                    child: const Text("Retry"),
                  ) : SizedBox(),
                ],
              ),
            );
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
