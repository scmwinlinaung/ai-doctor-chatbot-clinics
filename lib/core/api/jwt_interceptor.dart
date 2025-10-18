import 'package:dio/dio.dart';
import 'package:clinics/features/auth/services/token_storage_service.dart';

class JwtInterceptor extends Interceptor {
  final TokenStorageService _tokenStorageService;

  JwtInterceptor(this._tokenStorageService);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String? token = await _tokenStorageService.getToken();

    if (token != null && token.isNotEmpty) {
      options.headers['x-auth-token'] = token;
      print("Authorization header has been added to the request.");
    } else {
      print("No token found. Proceeding without Authorization header.");
    }
    return handler.next(options);
  }
}
