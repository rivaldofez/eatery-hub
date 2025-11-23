import 'package:eateryhub/data/local/local_database_service.dart';
import 'package:eateryhub/data/model/restaurant.dart';
import 'package:flutter/foundation.dart';

class FavoriteProvider extends ChangeNotifier {
  final LocalDatabaseService _service;

  FavoriteProvider(this._service);

  String _message = "";
  String get message => _message;

  List<Restaurant>? _restaurantList;
  List<Restaurant>? get restaurantList => _restaurantList;

  Restaurant? _restaurant;
  Restaurant? get restaurant => _restaurant;

  Future<void> saveRestaurant(Restaurant value) async {
    try {
      final result = await _service.insertItem(value);

      final isError = result == 0;
      if (isError) {
        _message = "Failed to save your data";
        notifyListeners();
      } else {
        _message = "Your data is saved";
        notifyListeners();
      }
    } catch (e) {
      _message = "Failed to save your data";
      notifyListeners();
    }
  }

  Future<void> loadFavoriteRestaurants() async {
    try {
      _restaurantList = await _service.getListFavorite();
      _message = "All of your data is laoded";
      notifyListeners();
    } catch (e) {
      _message = "Failed to load all data";
      notifyListeners();
    }
  }

  Future<void> loadRestaurantById(String id) async {
    try {
      _restaurant = await _service.getRestaurantById(id);
      _message = "Your data is loaded";
      notifyListeners();
    } catch (e) {
      _message = "Failed to load your data";
      notifyListeners();
    }
  }

  Future<void> removeRestaurantById(String id) async {
    try {
      await _service.removeRestaurantById(id);
      _message = "Your data is removed";
      notifyListeners();
    } catch (e) {
      _message = "Failed to remove your data";
      notifyListeners();
    }
  }

  bool checkItemFavorite(String id) {
    final isSameRestaurant = _restaurant?.id == id;
    return isSameRestaurant;
  }
}
