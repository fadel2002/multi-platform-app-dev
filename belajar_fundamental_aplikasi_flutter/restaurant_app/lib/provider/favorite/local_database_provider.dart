import 'package:flutter/material.dart';

import '../../data/local/local_database_service.dart';
import '../../data/model/restaurant.dart';
import '../../utils/enums.dart';
import '../connection/connectivity_provider.dart';

class LocalDatabaseProvider extends ChangeNotifier {
  final LocalDatabaseService _service;
  final ConnectivityProvider _connectivityProvider;

  LocalDatabaseProvider(this._service, this._connectivityProvider);

  String _isError = ErrorType.none.name;
  String get isError => _isError;
  String _message = "";
  String get message => _message;

  List<Restaurant>? _restaurantList;
  List<Restaurant>? get restaurantList => _restaurantList;

  Restaurant? _restaurant;

  Future<void> saveRestaurant(Restaurant value) async {
    try {
      final result = await _service.insertItem(value);

      final isError = result == 0;
      if (isError) {
        _message = "Failed to save your data";
      } else {
        _message = "Your data is saved";
      }
    } catch (e) {
      _message = "Failed to save your data";
    }
    notifyListeners();
  }

  Future<void> loadAllRestaurant() async {
    _isError = ErrorType.none.name;
    notifyListeners();
    if (!_connectivityProvider.hasInternetConnection) {
      _isError = ErrorType.noInternetConnection.name;
      notifyListeners();
      return;
    }

    try {
      _restaurantList = await _service.getAllItems();
      _restaurant = null;
      _message = "All of your data is loaded";
      notifyListeners();
    } catch (e) {
      _message = "Failed to load your all data";
      notifyListeners();
    }
  }

  Future<void> loadRestaurantById(String id) async {
    try {
      _restaurant = await _service.getItemById(id);
      _message = "Your data is loaded";
      notifyListeners();
    } catch (e) {
      _message = "Failed to load your data $e";
      notifyListeners();
    }
  }

  Future<void> removeRestaurantById(String id) async {
    try {
      await _service.removeItem(id);
      _message = "Your data is removed";
      _restaurantList = await _service.getAllItems();
      _restaurant = null;
      notifyListeners();
    } catch (e) {
      _message = "Failed to remove your data";
      notifyListeners();
    }
  }

  bool checkItemFavorite(String id) {
    final isSameRestaurant = _restaurant == null
        ? false
        : _restaurant?.id == id;
    return isSameRestaurant;
  }
}