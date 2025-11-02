
import 'dart:async';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  static String humanize(Object error) {
    if (error is ApiException) {
      if (error.statusCode == 404) return 'Data tidak ditemukan';
      if (error.statusCode == 500) return 'Terjadi kendala pada server, silakan coba lagi';
      return error.message;
    } else if (error is FormatException) {
      return 'Format dari server tidak dikenali, silakan coba lagi';
    } else if (error is TimeoutException) {
      return 'Koneksi membutuhkan waktu dan berakhir, periksa kembali jaringan dan coba lagi';
    } else if (error.toString().contains('SocketException')) {
      return 'Tidak ada koneksi internet, periksa kembali dan coba lagi';
    } else {
      return 'Terjadi kesalahan, silakan coba lagi';
    }
  }

  @override
  String toString() => message;
}