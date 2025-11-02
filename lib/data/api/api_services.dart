import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:eateryhub/data/model/detail_restaurant_response.dart';
import 'package:http/http.dart' as http;
import 'package:eateryhub/data/model/restaurant_list_response.dart';

class ApiServices {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";

  // Handler umum untuk request API
  Future<T> _handleRequest<T>(
    Uri url,
    T Function(dynamic json) parser, {
    String defaultError = "Terjadi kesalahan, silakan coba lagi nanti.",
  }) async {
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return parser(jsonData);
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        throw Exception(
          "Permintaan gagal. Periksa kembali data yang Anda kirimkan.",
        );
      } else if (response.statusCode >= 500) {
        throw Exception(
          "Server sedang mengalami gangguan. Silakan coba beberapa saat lagi.",
        );
      } else {
        throw Exception(defaultError);
      }
    } on SocketException {
      throw Exception(
        "Tidak ada koneksi internet. Periksa jaringan Anda dan coba lagi.",
      );
    } on FormatException {
      throw Exception("Gagal membaca respon dari server.");
    } on TimeoutException {
      throw Exception("Permintaan terlalu lama. Silakan coba lagi.");
    } catch (e) {
      throw Exception(defaultError);
    }
  }

  Future<RestaurantListResponse> getRestaurantList() {
    return _handleRequest<RestaurantListResponse>(
      Uri.parse("$_baseUrl/list"),
      (json) => RestaurantListResponse.fromJson(json),
      defaultError: "Gagal memuat daftar restoran.",
    );
  }

  Future<DetailRestaurantResponse> getDetailRestaurant(String id) {
    return _handleRequest<DetailRestaurantResponse>(
      Uri.parse("$_baseUrl/detail/$id"),
      (json) => DetailRestaurantResponse.fromJson(json),
      defaultError: "Gagal memuat detail restoran.",
    );
  }
}
