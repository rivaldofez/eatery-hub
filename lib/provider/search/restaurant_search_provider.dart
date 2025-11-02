import 'package:eateryhub/data/api/api_exception.dart';
import 'package:eateryhub/data/api/api_services.dart';
import 'package:eateryhub/data/model/restaurant.dart';
import 'package:eateryhub/static/base_result_state.dart';
import 'package:flutter/widgets.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantSearchProvider(this._apiServices);

  ResultState<List<Restaurant>> _resultState = NoneState<List<Restaurant>>();

  ResultState<List<Restaurant>> get resultState => _resultState;

  Future<void> fetchSearchRestaurantList(String query) async {
    if (query.isEmpty) { 
      _resultState = NoneState<List<Restaurant>>();
        notifyListeners();
        return;
    }

    try {
      _resultState = LoadingState<List<Restaurant>>();
      notifyListeners();

      final result = await _apiServices.getSearchRestaurantList(query);

      if (result.error) {
        _resultState = ErrorState<List<Restaurant>>(result.message ?? "");
        notifyListeners();
      } else {
        _resultState = LoadedState<List<Restaurant>>(result.restaurants);
        notifyListeners();
      }
    } on Exception catch (e) {
      final message = ApiException.humanize(e);
      _resultState = ErrorState<List<Restaurant>>(message);
      notifyListeners();
    }
  }
}