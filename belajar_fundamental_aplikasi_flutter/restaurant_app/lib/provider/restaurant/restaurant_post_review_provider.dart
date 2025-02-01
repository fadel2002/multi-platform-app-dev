import 'package:belajar_fundamental_aplikasi_flutter/utils/enums.dart';
import 'package:flutter/material.dart';

import '../../data/api/api_service.dart';
import '../../static/restaurant_post_review_state.dart';
import '../connection/connectivity_provider.dart';

class RestaurantPostReviewProvider extends ChangeNotifier {
  final ApiServices _apiServices;
  final ConnectivityProvider _connectivityProvider;
  bool _isLoading = false;

  RestaurantPostReviewProvider(this._apiServices, this._connectivityProvider);

  RestaurantPostReviewResultState _resultState = RestaurantPostReviewNoneState();

  RestaurantPostReviewResultState get resultState => _resultState;
  bool get isLoading => _isLoading;

  Future<void> postRestaurantReview(String id, String name, String review) async {
    if (!_connectivityProvider.hasInternetConnection) {
      _resultState = RestaurantPostReviewErrorState(ErrorType.noInternetConnection.name);
      notifyListeners();
      return;
    }

    try {
      _resultState = RestaurantPostReviewLoadingState();
      _isLoading = true;
      notifyListeners();

      final result = await _apiServices.postRestaurantReview(id, name, review);
      if (result.error) {
        _resultState = RestaurantPostReviewErrorState(ErrorType.apiFetchError.name);
      } else {
        _resultState = RestaurantPostReviewLoadedState(result.customerReviews);
      }
      _isLoading = false;
      notifyListeners();
    } on Exception catch (e) {
      _resultState = RestaurantPostReviewErrorState(e.toString());
      _isLoading = false;
      notifyListeners();
    }
  }
}