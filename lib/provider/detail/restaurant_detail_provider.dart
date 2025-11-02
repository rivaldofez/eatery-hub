import 'package:eateryhub/data/api/api_services.dart';
import 'package:eateryhub/data/model/detail_restaurant.dart';
import 'package:eateryhub/static/base_result_state.dart';
import 'package:flutter/material.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantDetailProvider(this._apiServices);

  ResultState<DetailRestaurant> _resultState = NoneState<DetailRestaurant>();

  ResultState<DetailRestaurant> get resultState => _resultState;

  Future<void> fetchRestaurantDetail(String id) async {
    try {
      _resultState = LoadingState<DetailRestaurant>();
      notifyListeners();

      final result = await _apiServices.getDetailRestaurant(id);

      if (result.error) {
        _resultState = ErrorState<DetailRestaurant>(result.message);
        notifyListeners();
      } else {
        _resultState = LoadedState<DetailRestaurant>(result.restaurant);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = ErrorState(e.toString());
      notifyListeners();
    }
  }
}