import 'package:flutter/material.dart';

import '../../data/api/api_service.dart';
import '../../static/restaurant_search_result_state.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiServices _apiServices;
  bool _isSearching = false;

  RestaurantSearchProvider(this._apiServices);

  RestaurantSearchResultState _resultState = RestaurantSearchNoneState();

  RestaurantSearchResultState get resultState => _resultState;
  bool get isSearching => _isSearching;

  void startSearching() {
    _isSearching = true;
    notifyListeners();
  }

  void stopSearching() {
    _isSearching = false;
    notifyListeners();
  }

  Future<void> fetchRestaurantSearch(String query) async {
    if (query.isEmpty) {
      stopSearching();
      return;
    }

    _isSearching = true;
    _resultState = RestaurantSearchLoadingState();
    notifyListeners();

    try {
      final result = await _apiServices.getRestaurantSearch(query);

      if (result.error) {
        _resultState = RestaurantSearchErrorState(result.error.toString());
      } else {
        _resultState = RestaurantSearchLoadedState(result.restaurants);
      }
      notifyListeners();
    } on Exception catch (e) {
      _resultState = RestaurantSearchErrorState(e.toString());
      notifyListeners();
    }
  }
}