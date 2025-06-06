import 'dart:convert';
import 'dart:developer';

import 'package:canaryfarm_app/data/models/request/admin/posting_jual_request.dart';
import 'package:canaryfarm_app/data/models/response/burung_semua_tersedia_model.dart';
import 'package:canaryfarm_app/data/models/response/get_all_burung_response_model.dart';
import 'package:canaryfarm_app/services/service_http_client.dart';
import 'package:dartz/dartz.dart';

class PostingRepository {
  final ServiceHttpClient _serviceHttpClient;
  PostingRepository(this._serviceHttpClient);

  Future<Either<String, BurungSemuaTersediabyIdModel>> addPostBurung(
    PostingJualRequestModel requestModel,
  ) async {
    try {
      final response = await _serviceHttpClient.postWithToken(
        "admin/posting-jual",
        requestModel.toJson(),
      );
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 201) {
        final profileResponse = BurungSemuaTersediabyIdModel.fromJson(
          jsonResponse,
        );
        log("Add Burung successfull: ${profileResponse.message}");
        return Right(profileResponse);
      } else {
        log("Add burung failed: ${jsonResponse['message']}");
        return Left(jsonResponse['message'] ?? "Add burung failed");
      }
    } catch (e) {
      log("Error in Add burung : $e");
      return Left("An error occured while pos burung: $e");
    }
  }

  Future<Either<String, GetAllBurungModel>> getAllBurung() async {
    try {
      final response = await _serviceHttpClient.get("admin/burung-semua");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final getAllBurung = GetAllBurungModel.fromMap(jsonResponse);
        return Right(getAllBurung);
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Get all burung failed');
      }
    } catch (e) {
      return Left("An error occured while getting all burung: $e");
    }
  }
}
