import 'dart:convert';

import 'restaurant.dart';

RestaurantPostReviewResponse customerPostReviewResponseFromJson(String str) => RestaurantPostReviewResponse.fromJson(json.decode(str));

String customerPostReviewResponseToJson(RestaurantPostReviewResponse data) => json.encode(data.toJson());

class RestaurantPostReviewResponse {
  bool error;
  String message;
  List<CustomerReview> customerReviews;

  RestaurantPostReviewResponse({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  factory RestaurantPostReviewResponse.fromJson(Map<String, dynamic> json) => RestaurantPostReviewResponse(
    error: json["error"],
    message: json["message"],
    customerReviews: List<CustomerReview>.from(json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "customerReviews": List<dynamic>.from(customerReviews.map((x) => x.toJson())),
  };
}