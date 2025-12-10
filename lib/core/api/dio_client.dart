import 'package:clinics/core/config/app_config.dart';
import 'package:clinics/features/auth/services/token_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'jwt_interceptor.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl:
          "https://${AppConfig.host}/api", // Using HTTPS with self-signed cert
      connectTimeout: const Duration(seconds: 120),
      receiveTimeout: const Duration(seconds: 120),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  static Dio get instance {
    // Disable SSL certificate verification for development with self-signed certs
    (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback = (cert, host, port) => true;
      return client;
    };

    _dio.interceptors.add(JwtInterceptor(TokenStorageService()));
    return _dio;
  }

  // For development with self-signed certificates
  static Dio get instanceWithBadCert {
    final dio = Dio(
      BaseOptions(
        baseUrl: "https://${AppConfig.host}/api",
        connectTimeout: const Duration(seconds: 120),
        receiveTimeout: const Duration(seconds: 120),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Disable SSL certificate verification for development
    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback = (cert, host, port) => true;
      return client;
    };

    dio.interceptors.add(JwtInterceptor(TokenStorageService()));
    return dio;
  }
}
