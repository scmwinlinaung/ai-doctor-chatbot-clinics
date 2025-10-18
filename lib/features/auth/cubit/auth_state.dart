part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.authenticated(String token) = AuthAuthenticated;
  const factory AuthState.unauthenticated(String error) = AuthUnauthenticated;
  const factory AuthState.succss(String message) = Success;
  const factory AuthState.failure(String error) = Failure;
}
