import 'package:dartz/dartz.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:canaryfarm_app/data/models/request/admin/admin_profile_request.dart';
import 'package:canaryfarm_app/data/models/response/admin_profile_response_model.dart';
import 'package:canaryfarm_app/services/service_http_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfileAdminRepository {
  final ServiceHttpClient _serviceHttpClient;
  final secureStorage = FlutterSecureStorage();

  ProfileAdminRepository(this._serviceHttpClient);
  Future<Either<String, AdminProfileResponseModel>> addProfile(
    AdminProfileRequestModel requestModel,
  ) async {
    try {
      final response = await _serviceHttpClient.postWithToken(
        'admin/profile',
        requestModel.toMap(),
      );
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 201) {
        final profileResponse = AdminProfileResponseModel.fromMap(jsonResponse);
        log("Add Admin Profile successfull: ${profileResponse.message}");
        return Right(profileResponse);
      } else {
        log("Add Admin Profile failed: ${jsonResponse['message']}");
        return Left(jsonResponse['message'] ?? "Create Profile failed");
      }
    } catch (e) {
      log("Error in adding profile: $e");
      return Left("An error occured while adding profile: $e");
    }
  }

  Future<Either<String, AdminProfileResponseModel>> getProfile() async {
    try {
      final response = await _serviceHttpClient.get("admin/profile");
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final profilResponse = AdminProfileResponseModel.fromMap(jsonResponse);
        log("Get Admin Profile Successfull: ${profilResponse.message}");
        return Right(profilResponse);
      } else {
        final jsonResponse = json.decode(response.body);
        log("Get Admin Profile failed: ${jsonResponse['message']}");
        return Left(jsonResponse['message'] ?? "Get Profile failed");
      }
    } catch (e) {
      log("Error in getting profile: $e");
      return Left("An error occured while getting profile: $e");
    }
  }
}
