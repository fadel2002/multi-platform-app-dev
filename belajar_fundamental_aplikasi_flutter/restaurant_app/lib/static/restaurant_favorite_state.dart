import '../data/model/restaurant.dart';

sealed class RestaurantFavoriteResultState {}

class RestaurantFavoriteNoneState extends RestaurantFavoriteResultState {}

class RestaurantFavoriteLoadingState extends RestaurantFavoriteResultState {}

class RestaurantFavoriteErrorState extends RestaurantFavoriteResultState {
  final String error;

  RestaurantFavoriteErrorState(this.error);
}

class RestaurantFavoriteLoadedState extends RestaurantFavoriteResultState {
  final Restaurant data;

  RestaurantFavoriteLoadedState(this.data);
}