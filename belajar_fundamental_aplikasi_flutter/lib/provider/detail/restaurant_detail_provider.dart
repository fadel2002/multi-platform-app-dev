import 'package:flutter/material.dart';

import '../../data/api/api_service.dart';
import '../../static/restaurant_detail_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantDetailProvider(this._apiServices);

  RestaurantDetailResultState _resultState = RestaurantDetailNoneState();

  RestaurantDetailResultState get resultState => _resultState;

  Future<void> fetchRestaurantDetail(String restaurantId) async {
    try {
      _resultState = RestaurantDetailLoadingState();
      notifyListeners();

      final result = await _apiServices.getRestaurantDetail(restaurantId);

      if (result.error) {
        _resultState = RestaurantDetailErrorState(result.message);
      } else {
        _resultState = RestaurantDetailLoadedState(result.restaurant);
      }
      notifyListeners();
    } on Exception catch (e) {
      _resultState = RestaurantDetailErrorState(e.toString());
      notifyListeners();
    }
  }
}