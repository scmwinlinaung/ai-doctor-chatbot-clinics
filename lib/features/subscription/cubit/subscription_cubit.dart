import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  SubscriptionCubit() : super(SubscriptionInitial());

  void fetchPackages() {
    emit(SubscriptionLoading());
    // TODO: Fetch subscription packages from your API
    Future.delayed(const Duration(seconds: 2), () {
      final packages = ['Basic - \$9.99/mo', 'Premium - \$19.99/mo'];
      emit(SubscriptionLoaded(packages));
    });
  }
}
