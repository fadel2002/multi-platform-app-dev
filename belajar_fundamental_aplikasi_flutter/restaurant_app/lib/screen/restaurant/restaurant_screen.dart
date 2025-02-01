import 'package:belajar_fundamental_aplikasi_flutter/provider/restaurant/restaurant_list_provider.dart';
import 'package:belajar_fundamental_aplikasi_flutter/screen/restaurant/restaurant_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../provider/restaurant/restaurant_search_provider.dart';
import '../../static/navigation_route.dart';
import '../../static/restaurant_list_result_state.dart';
import '../../static/restaurant_search_result_state.dart';
import '../../utils/enums.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({super.key});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  final TextEditingController _searchController = TextEditingController();
  void _onSearchChanged(String query) {
    final searchProvider = context.read<RestaurantSearchProvider>();
    if (query.isEmpty) {
      searchProvider.stopSearching();
    } else {
      searchProvider.startSearching();
      searchProvider.fetchRestaurantSearch(query);
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context
          .read<RestaurantListProvider>()
          .fetchRestaurantList();
    });
  }
  @override
  Widget build(BuildContext context) {
    final isSearching = context.watch<RestaurantSearchProvider>().isSearching;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant List"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: "Search restaurant...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Expanded(
            child: isSearching
                ? Consumer<RestaurantSearchProvider>(
              builder: (context, value, child) {
                return switch (value.resultState) {
                  RestaurantSearchLoadingState() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  RestaurantSearchLoadedState(data: var searchResults) => searchResults.isEmpty
                      ? Center(child: Text("No search results found", style: Theme.of(context).textTheme.bodyLarge))
                      : ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final restaurant = searchResults[index];
                      return RestaurantCardWidget(
                        restaurant: restaurant,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            NavigationRoute.detailRoute.name,
                            arguments: restaurant.id,
                          );
                        },
                      );
                    },
                  ),
                  RestaurantSearchErrorState(error: var message) =>
                      ErrorSearchWidget(message: message, query: _searchController.text.trim()),
                  _ => const SizedBox(),
                };
              },
            )
                : Consumer<RestaurantListProvider>(
              builder: (context, value, child) {
                return switch (value.resultState) {
                  RestaurantListLoadingState() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  RestaurantListLoadedState(data: var restaurantList) => ListView.builder(
                      itemCount: restaurantList.length,
                      itemBuilder: (context, index) {
                        final restaurant = restaurantList[index];
                        return RestaurantCardWidget(
                          restaurant: restaurant,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              NavigationRoute.detailRoute.name,
                              arguments: restaurant.id,
                            );
                          },
                        );
                      },
                    ),
                  RestaurantListErrorState(
                    error: var message
                  ) => ErrorListWidget(message: message),
                  _ => const SizedBox(),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ErrorListWidget extends StatelessWidget {
  final String message;

  const ErrorListWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              message == ErrorType.apiFetchError.name
                  ? "Oops, something went wrong. Please try again later."
                  : "No internet connection found. Please check your connection and try again.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<RestaurantListProvider>().fetchRestaurantList();
            },
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }
}

class ErrorSearchWidget extends StatelessWidget {
  final String message;
  final String query;

  const ErrorSearchWidget({super.key, required this.message, required this.query});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              message == ErrorType.apiFetchError.name
                  ? "Oops, something went wrong. Please try again later."
                  : "No internet connection found. Please check your connection and try again.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          ElevatedButton(
            onPressed: () {
                if (query.isNotEmpty) {
                  context.read<RestaurantSearchProvider>().fetchRestaurantSearch(query);
                }
              },
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }
}


