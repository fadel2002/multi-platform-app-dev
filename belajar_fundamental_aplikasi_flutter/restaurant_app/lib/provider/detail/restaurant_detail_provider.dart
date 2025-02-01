import 'package:flutter/material.dart';

import '../../data/api/api_service.dart';
import '../../static/restaurant_detail_state.dart';
import '../../utils/enums.dart';
import '../connection/connectivity_provider.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiServices _apiServices;
  final ConnectivityProvider _connectivityProvider;

  RestaurantDetailProvider(this._apiServices, this._connectivityProvider);

  RestaurantDetailResultState _resultState = RestaurantDetailNoneState();

  RestaurantDetailResultState get resultState => _resultState;

  Future<void> fetchRestaurantDetail(String restaurantId) async {
    if (!_connectivityProvider.hasInternetConnection) {
      _resultState = RestaurantDetailErrorState(ErrorType.noInternetConnection.name);
      notifyListeners();
      return;
    }

    try {
      _resultState = RestaurantDetailLoadingState();
      notifyListeners();

      final result = await _apiServices.getRestaurantDetail(restaurantId);

      if (result.error) {
        _resultState = RestaurantDetailErrorState(ErrorType.apiFetchError.name);
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