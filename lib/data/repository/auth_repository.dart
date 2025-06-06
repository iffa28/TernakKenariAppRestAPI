import 'dart:convert';

import 'package:canaryfarm_app/data/models/request/auth/login_request_model.dart';
import 'package:canaryfarm_app/data/models/request/auth/register_request_model.dart';
import 'package:canaryfarm_app/data/models/response/auth_response_model.dart';
import 'package:canaryfarm_app/services/service_http_client.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepository {
  final ServiceHttpClient _serviceHttpClient;
  final secureStorage = FlutterSecureStorage();

  AuthRepository(this._serviceHttpClient);

  Future<Either<String, AuthResponseModel>> login(
    LoginRequestModel model,
  ) async {
    try {
      final response = await _serviceHttpClient.post(
        'login', 
        model.toMap(),
      );

      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final authResponse = AuthResponseModel.fromMap(jsonResponse);

        final token = authResponse.user?.token;
        if (token != null) {
          await secureStorage.write(key: 'token', value: token);
        }

        return Right(authResponse);
      } else {
        return Left(jsonResponse["message"] ?? "Login gagal");
      }
    } catch (e) {
      return Left("Terjadi kesalahan: $e");
    }
  }

  // Method register
  Future<Either<String, String>> register(RegisterRequestModel data) async {
    try {
      final response = await _serviceHttpClient.post('register', data.toMap());

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return Right(jsonData['message'] ?? 'Register success');
      } else {
        final jsonData = jsonDecode(response.body);
        return Left(jsonData['message'] ?? 'Register failed');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
