
import 'package:eateryhub/data/model/detail_restaurant.dart';

class DetailRestaurantResponse {
    bool error;
    String message;
    DetailRestaurant restaurant;

    DetailRestaurantResponse({
        required this.error,
        required this.message,
        required this.restaurant,
    });

    factory DetailRestaurantResponse.fromJson(Map<String, dynamic> json) => DetailRestaurantResponse(
        error: json["error"],
        message: json["message"],
        restaurant: DetailRestaurant.fromJson(json["restaurant"]),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": restaurant.toJson(),
    };
}