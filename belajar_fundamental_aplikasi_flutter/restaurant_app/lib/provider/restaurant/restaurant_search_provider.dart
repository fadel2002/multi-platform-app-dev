import 'package:flutter/material.dart';

import '../../data/api/api_service.dart';
import '../../static/restaurant_search_result_state.dart';
import '../../utils/enums.dart';
import '../connection/connectivity_provider.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiServices _apiServices;
  final ConnectivityProvider _connectivityProvider;
  bool _isSearching = false;

  RestaurantSearchProvider(this._apiServices, this._connectivityProvider);

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
    if (!_connectivityProvider.hasInternetConnection) {
      _resultState = RestaurantSearchErrorState(ErrorType.noInternetConnection.name);
      notifyListeners();
      return;
    }

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
        _resultState = RestaurantSearchErrorState(ErrorType.apiFetchError.name);
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