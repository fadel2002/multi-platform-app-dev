import 'dart:convert';

import 'restaurant.dart';

RestaurantDetailResponse restaurantDetailResponseFromJson(String str) => RestaurantDetailResponse.fromJson(json.decode(str));

String restaurantDetailResponseToJson(RestaurantDetailResponse data) => json.encode(data.toJson());

class RestaurantDetailResponse {
  bool error;
  String message;
  Restaurant restaurant;

  RestaurantDetailResponse({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory RestaurantDetailResponse.fromJson(Map<String, dynamic> json) => RestaurantDetailResponse(
    error: json["error"],
    message: json["message"],
    restaurant: Restaurant.fromJson(json["restaurant"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "restaurant": restaurant.toJson(),
  };
}