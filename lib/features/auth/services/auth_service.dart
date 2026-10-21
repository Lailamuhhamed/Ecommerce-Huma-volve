import 'package:dio/dio.dart';
import '../model/Auth_response_model.dart';
import '../model/User_model.dart';
import 'api_service.dart';
import 'storage_service.dart';

class AuthService {
  final Dio _dio = ApiService().dio;
  final StorageService _storageService = StorageService();

  //  Login
  Future<AuthResponseModel> login(String email, String password) async {
    try {
      final response = await _dio.post(
        'auth/login',
        data: {'email': email, 'password': password},
      );

      final authResponse = AuthResponseModel.fromJson(response.data);

      // save token
      await _storageService.saveTokens(
        accessToken: authResponse.accessToken!,
        refreshToken: authResponse.refreshToken!,
      );

      return authResponse;
    } catch (e) {
      rethrow;
    }
  }

  // upload image
  Future<String> uploadAvatar(String filePath) async {
    try {
      String fileName = filePath.split('/').last;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(filePath, filename: fileName),
      });

      final response = await _dio.post('files/upload', data: formData);
      return response.data['location'];
    } catch (e) {
      rethrow;
    }
  }

  // create new acc
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
    required String avatarUrl,
  }) async {
    try {
      final response = await _dio.post(
        'users/',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'avatar': avatarUrl,
        },
      );

      return UserModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  // get profile
  Future<UserModel> getProfile() async {
    try {
      final response = await _dio.get('auth/profile');
      return UserModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  // logout
  Future<void> logout() async {
    await _storageService.clearTokens();
  }
}