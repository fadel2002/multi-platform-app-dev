import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../provider/detail/restaurant_detail_provider.dart';
import '../../static/restaurant_detail_state.dart';
import '../../utils/enums.dart';
import 'widget/restaurant_detail_screen_widget.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final String restaurantId;

  const RestaurantDetailScreen({super.key, required this.restaurantId});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {

@override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context
          .read<RestaurantDetailProvider>()
          .fetchRestaurantDetail(widget.restaurantId);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RestaurantDetailProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            RestaurantDetailLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
            RestaurantDetailLoadedState(data: var restaurant) =>
                RestaurantDetailScreenWidget(restaurant: restaurant),
            RestaurantDetailErrorState(
              error: var message
            ) => ErrorDetailWidget(message: message, restaurantId: widget.restaurantId),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}

class ErrorDetailWidget extends StatelessWidget {
  final String message;
  final String restaurantId;

  const ErrorDetailWidget({super.key, required this.message, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
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
              context.read<RestaurantDetailProvider>().fetchRestaurantDetail(restaurantId);
            },
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }
}
