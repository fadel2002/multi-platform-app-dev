import 'package:belajar_fundamental_aplikasi_flutter/data/model/restaurant.dart';

sealed class RestaurantPostReviewResultState {}

class RestaurantPostReviewNoneState extends RestaurantPostReviewResultState {}

class RestaurantPostReviewLoadingState extends RestaurantPostReviewResultState {}

class RestaurantPostReviewErrorState extends RestaurantPostReviewResultState {
  final String error;

  RestaurantPostReviewErrorState(this.error);
}

class RestaurantPostReviewLoadedState extends RestaurantPostReviewResultState {
  final List<CustomerReview> data;

  RestaurantPostReviewLoadedState(this.data);
}