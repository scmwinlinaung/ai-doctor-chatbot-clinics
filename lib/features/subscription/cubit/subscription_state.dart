// Create the corresponding state file
// lib/features/subscription/cubit/subscription_state.dart
part of 'subscription_cubit.dart';

@immutable
abstract class SubscriptionState {}

class SubscriptionInitial extends SubscriptionState {}

class SubscriptionLoading extends SubscriptionState {}

class SubscriptionLoaded extends SubscriptionState {
  final List<String> packages;
  SubscriptionLoaded(this.packages);
}

class SubscriptionError extends SubscriptionState {
  final String message;
  SubscriptionError(this.message);
}
