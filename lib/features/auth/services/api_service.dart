import 'package:dio/dio.dart';
import 'storage_service.dart';

class ApiService {
  late final Dio dio;
  final StorageService _storageService = StorageService();

  ApiService() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.escuelajs.co/api/v1/',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? token = await _storageService.getAccessToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) {
          return handler.next(error);
        },
      ),
    );
  }
}