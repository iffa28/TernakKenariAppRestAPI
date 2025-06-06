import 'dart:convert';
import 'dart:io';

import 'package:canaryfarm_app/data/models/response/burung_semua_tersedia_model.dart';
import 'package:canaryfarm_app/services/service_http_client.dart';
import 'package:dartz/dartz.dart';

class GetAllBurungTersediaRepository {
  final ServiceHttpClient httpClient;
  GetAllBurungTersediaRepository(this.httpClient);

  Future<Either<String, BurungSemuaTersediaModel>>
  getAllBurungTersedia() async {
    try {
      final response = await httpClient.get("buyer/burung-semua-tersedia");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final burungTersediaResponse = BurungSemuaTersediaModel.fromJson(
          jsonResponse,
        );
        return Right(burungTersediaResponse);
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Unknown error occured');
      }
    } catch (e) {
      if (e is SocketException) {
        return Left("No Internet connection");
      } else if (e is HttpException) {
        return Left("Http error: ${e.message}");
      } else if (e is FormatException) {
        return Left("Invalid response format");
      } else {
        return Left("An unexpected error occured: $e");
      }
    }
  }
}
