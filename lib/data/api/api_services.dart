import 'dart:convert';
import 'package:eateryhub/data/model/detail_restaurant_response.dart';
import 'package:http/http.dart' as http;
import 'package:eateryhub/data/model/restaurant_list_response.dart';


class ApiServices {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";

  Future<RestaurantListResponse> getRestaurantList() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));

    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to decode and load restaurant list");
    }
  }

  Future<DetailRestaurantResponse> getDetailRestaurant(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));

    if (response.statusCode == 200) {
      return DetailRestaurantResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to decode and load restaurant list");
    }
  }
}