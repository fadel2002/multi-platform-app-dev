import 'package:belajar_fundamental_aplikasi_flutter/data/model/restaurant.dart';
import 'package:flutter/widgets.dart';


class FavoriteListProvider extends ChangeNotifier {
  final List<Restaurant> _favoriteList = [];

  List<Restaurant> get bookmarkList => _favoriteList;

  void addBookmark(Restaurant value) {
    _favoriteList.add(value);
    notifyListeners();
  }

  void removeBookmark(Restaurant value) {
    _favoriteList.removeWhere((element) => element.id == value.id);
    notifyListeners();
  }

  bool checkItemBookmark(Restaurant value) {
    final tourismInList =
    _favoriteList.where((element) => element.id == value.id);
    return tourismInList.isNotEmpty;
  }
}