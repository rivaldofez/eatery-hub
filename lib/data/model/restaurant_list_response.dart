// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:eateryhub/data/model/restaurant.dart';
import 'package:equatable/equatable.dart';

class RestaurantListResponse extends Equatable {
  final bool error;
  final String? message;
  final List<Restaurant> restaurants;

  RestaurantListResponse({
    required this.error,
    required this.message,
    required this.restaurants,
  });

  factory RestaurantListResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantListResponse(
        error: json["error"],
        message: json["message"],
        restaurants: List<Restaurant>.from(
          json["restaurants"].map((x) => Restaurant.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
  };

  @override
  List<Object?> get props => [error, message, restaurants];
}
