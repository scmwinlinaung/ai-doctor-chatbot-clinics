import 'package:dio/dio.dart';
import 'package:clinics/core/config/app_config.dart';
import 'package:clinics/features/auth/services/token_storage_service.dart';
import 'jwt_interceptor.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://${AppConfig.host}/api", // Changed to HTTP for IP address
      connectTimeout: const Duration(seconds: 50),
      receiveTimeout: const Duration(seconds: 50),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  )..interceptors.add(JwtInterceptor(TokenStorageService()));

  static Dio get instance => _dio;
}
