import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/model/restaurant.dart';
import '../../../provider/restaurant/restaurant_post_review_provider.dart';
import '../../../provider/settings/settings_provider.dart';
import '../../../static/restaurant_post_review_state.dart';
import 'restaurant_review_list_widget.dart';

class RestaurantDetailFooterWidget extends StatefulWidget {
  final List<CustomerReview>? customerReviews;
  final String restaurantId;

  const RestaurantDetailFooterWidget({super.key, required this.customerReviews, required this.restaurantId});

  @override
  State<RestaurantDetailFooterWidget> createState() => _RestaurantDetailFooterWidgetState();
}

class _RestaurantDetailFooterWidgetState extends State<RestaurantDetailFooterWidget> {
  final TextEditingController _reviewController = TextEditingController();
  void _onPress() {
    String review = _reviewController.text.trim();
    final postProvider = context.read<RestaurantPostReviewProvider>();
    final pref = context.read<SettingsProvider>();
    if (review.isNotEmpty) {
      postProvider.postRestaurantReview(widget.restaurantId, pref.username, review);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Review submitted successfully!"), behavior: SnackBarBehavior.floating),
      );
      _reviewController.clear();
    }else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill the review field."), behavior: SnackBarBehavior.floating),
      );
    }
  }

  @override
  dispose(){
    _reviewController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final postProvider = context.read<RestaurantPostReviewProvider>();
      postProvider.resetState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Reviews",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Row(
          spacing: 6,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: _reviewController,
                decoration: InputDecoration(
                  hintText: "Review",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Consumer<RestaurantPostReviewProvider>(
              builder: (context, postProvider, child) {
                return ElevatedButton(
                  onPressed: _onPress,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)
                    ),
                    minimumSize: Size(80, 55),
                    padding: EdgeInsets.zero,
                  ),
                  child: postProvider.isLoading
                      ? CircularProgressIndicator()
                      : Text("Submit"),
                );
              },
            ),
          ],
        ),
        Consumer<RestaurantPostReviewProvider>(
          builder: (context, value, child) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (value.resultState is RestaurantPostReviewErrorState) {
                final errorState = value.resultState as RestaurantPostReviewErrorState;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(errorState.error), behavior: SnackBarBehavior.floating),
                );
              }
            });
            return switch (value.resultState) {
              RestaurantPostReviewLoadingState() => const Center(
                child: CircularProgressIndicator(),
              ),
              RestaurantPostReviewLoadedState(
                data: var reviews
              ) => RestaurantReviewListWidget(customerReviews: reviews),
              _ => RestaurantReviewListWidget(customerReviews: widget.customerReviews),
            };
          },
        ),
      ],
    );
  }
}
