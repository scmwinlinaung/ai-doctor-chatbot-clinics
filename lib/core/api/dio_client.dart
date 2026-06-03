import 'dart:io';
import 'package:clinics/core/config/app_config.dart';
import 'package:clinics/features/auth/services/token_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'jwt_interceptor.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://${AppConfig.host}/api",
      connectTimeout: const Duration(seconds: 30), // Reduced from 120 for faster failover
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Connection': 'close', // Disable persistent connections to avoid 103 error
      },
    ),
  );

  static Dio get instance {
    _dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        // Disable SSL verification for development
        client.badCertificateCallback = (cert, host, port) => true;
        // Increase reliability for mobile networks
        client.connectionTimeout = const Duration(seconds: 30);
        return client;
      },
    );

    if (_dio.interceptors.whereType<JwtInterceptor>().isEmpty) {
      _dio.interceptors.add(JwtInterceptor(TokenStorageService()));
    }
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
