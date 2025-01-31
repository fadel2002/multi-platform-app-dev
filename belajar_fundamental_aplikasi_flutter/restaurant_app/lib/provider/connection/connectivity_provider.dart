import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityProvider with ChangeNotifier {
  bool _hasInternetConnection = true;
  bool get hasInternetConnection => _hasInternetConnection;

  ConnectivityProvider() {
    _initializeConnectivity();
  }

  Future<void> _initializeConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    _hasInternetConnection = connectivityResult.contains(ConnectivityResult.none) ? false : true;
    notifyListeners();

    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      _hasInternetConnection = result.contains(ConnectivityResult.none) ? false : true;
      notifyListeners();
    });
  }
}