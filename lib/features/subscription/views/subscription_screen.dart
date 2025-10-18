import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinics/core/widgets/custom_button.dart';
import 'package:clinics/core/widgets/loading_overlay.dart';
import 'package:clinics/features/subscription/cubit/subscription_cubit.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubscriptionCubit()..fetchPackages(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Subscription')),
        body: BlocBuilder<SubscriptionCubit, SubscriptionState>(
          builder: (context, state) {
            if (state is SubscriptionLoading) {
              return const Center(child: LoadingWidget());
            } else if (state is SubscriptionLoaded) {
              return ListView.builder(
                itemCount: state.packages.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            state.packages[index],
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 16),
                          CustomButton(
                            text: 'Subscribe Now',
                            onPressed: () {
                              // TODO: Implement subscription logic
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text('Failed to load packages'));
            }
          },
        ),
      ),
    );
  }
}
