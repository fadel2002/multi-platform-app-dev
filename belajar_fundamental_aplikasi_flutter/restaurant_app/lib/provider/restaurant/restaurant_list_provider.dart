import 'package:flutter/material.dart';

import '../../data/api/api_service.dart';
import '../../static/restaurant_list_result_state.dart';
import '../../utils/enums.dart';
import '../connection/connectivity_provider.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiServices _apiServices;
  final ConnectivityProvider _connectivityProvider;

  RestaurantListProvider(this._apiServices, this._connectivityProvider);

  RestaurantListResultState _resultState = RestaurantListNoneState();

  RestaurantListResultState get resultState => _resultState;

  Future<void> fetchRestaurantList() async {
    if (!_connectivityProvider.hasInternetConnection) {
      _resultState = RestaurantListErrorState(ErrorType.noInternetConnection.name);
      notifyListeners();
      return;
    }

    try {
      _resultState = RestaurantListLoadingState();
      notifyListeners();

      final result = await _apiServices.getRestaurantList();

      if (result.error) {
        _resultState = RestaurantListErrorState(ErrorType.apiFetchError.name);
      } else {
        _resultState = RestaurantListLoadedState(result.restaurants);
      }
      notifyListeners();
    } on Exception catch (e) {
      _resultState = RestaurantListErrorState(e.toString());
      notifyListeners();
    }
  }
}