import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:clinics/core/navigation/app_routes.dart';
import 'package:clinics/core/widgets/custom_back_button.dart';
import 'package:clinics/core/widgets/gradient_background.dart';
import 'package:clinics/features/chatbot/cubit/chatbot_cubit.dart';
import 'package:clinics/features/chatbot/cubit/language_cubit.dart';
import 'package:clinics/features/chatbot/widgets/message_bubble.dart';

class ChatbotScreen extends StatelessWidget {
  final String? initialMessageEn;
  final String? initialMessageMM;
  const ChatbotScreen({
    super.key,
    this.initialMessageEn,
    this.initialMessageMM,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, languageState) {
        return BlocProvider(
          create: (context) => GetIt.instance<ChatbotCubit>()
            ..onStarted(
              initialMessage: languageState.currentLanguage == "mm"
                  ? initialMessageMM
                  : initialMessageEn,
              language: languageState.currentLanguage == "mm"
                  ? "myanmar"
                  : "english",
            ),
          child: const ChatbotView(),
        );
      },
    );
  }
}

class ChatbotView extends StatefulWidget {
  const ChatbotView({super.key});

  @override
  State<ChatbotView> createState() => _ChatbotViewState();
}

class _ChatbotViewState extends State<ChatbotView> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final ScrollController _scrollController = ScrollController();
  int _previousMessageCount = 0;
  bool _previousIsAiTyping = false;

  @override
  void initState() {
    super.initState();
    final initialState = context.read<ChatbotCubit>().state;
    _previousMessageCount = initialState.messages.length;
    _previousIsAiTyping = initialState.isAiTyping;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(
          callback: () => {Navigator.of(context).pop()},
          iconColor: Theme.of(context).primaryColor,
        ),
        elevation: 0,
        centerTitle: true,
        title: const Text('AI Health Guide'),
        flexibleSpace: const GradientBackground(child: SizedBox.shrink()),
      ),
      //
      // --- CHANGE 1: ADD FLOATING ACTION BUTTON ---
      //
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            backgroundColor: Theme.of(
              context,
            ).primaryColor.withValues(alpha: 0.8, green: 0.8),
            onPressed: () {
              context.go(AppRoutes.home);
            },
            icon: const Icon(Icons.home_filled, color: Colors.white),
            label: Text(
              'Back to Home',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(color: Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          FloatingActionButton.extended(
            backgroundColor: Theme.of(
              context,
            ).primaryColor.withValues(alpha: 0.8, green: 0.8),
            onPressed: () {
              context.go(AppRoutes.clinics);
            },
            icon: const Icon(
              Icons.calendar_month_outlined,
              color: Colors.white,
            ),
            label: Text(
              'Back to Booking',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
      //
      // --- CHANGE 2: SET BUTTON LOCATION ---
      //
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 85),
          child: Column(
            children: [
              Expanded(
                child: BlocListener<ChatbotCubit, ChatbotState>(
                  listenWhen: (previousState, currentState) =>
                      previousState.messages.length <
                          currentState.messages.length ||
                      previousState.isAiTyping != currentState.isAiTyping,
                  listener: (context, state) {
                    if (state.messages.length > _previousMessageCount &&
                        _listKey.currentState != null) {
                      final int newMessagesCount =
                          state.messages.length - _previousMessageCount;
                      for (int i = 0; i < newMessagesCount; i++) {
                        _listKey.currentState?.insertItem(
                          state.messages.length - newMessagesCount + i,
                          duration: const Duration(milliseconds: 500),
                        );
                      }
                    }

                    if (state.isAiTyping && !_previousIsAiTyping) {
                      _listKey.currentState?.insertItem(
                        state.messages.length,
                        duration: const Duration(milliseconds: 300),
                      );
                    } else if (!state.isAiTyping && _previousIsAiTyping) {
                      _listKey.currentState?.removeItem(
                        state.messages.length,
                        (context, animation) => const SizedBox.shrink(),
                        duration: const Duration(milliseconds: 300),
                      );
                    }

                    _previousMessageCount = state.messages.length;
                    _previousIsAiTyping = state.isAiTyping;
                  },
                  child: BlocBuilder<ChatbotCubit, ChatbotState>(
                    builder: (context, state) {
                      final int itemCount =
                          state.messages.length + (state.isAiTyping ? 1 : 0);

                      return AnimatedList(
                        key: _listKey,
                        controller: _scrollController,
                        //
                        // --- CHANGE 3: ADD PADDING TO AVOID OVERLAP ---
                        //
                        padding: const EdgeInsets.fromLTRB(
                          16.0,
                          8.0,
                          16.0,
                          80.0,
                        ), // Added 80px bottom padding
                        initialItemCount: itemCount,
                        itemBuilder: (context, index, animation) {
                          if (index == state.messages.length &&
                              state.isAiTyping) {
                            // This is the typing indicator
                            return FadeTransition(
                              opacity: animation,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Theme.of(
                                          context,
                                        ).colorScheme.surface,
                                        child: Icon(
                                          Icons.support_agent,
                                          size: 20,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.surface,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: const AnimatedTypingIndicator(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                          // This is a regular message bubble
                          return MessageBubble(
                            message: state.messages[index],
                            animation: animation,
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              // The input bar remains at the bottom of the Column
            ],
          ),
        ),
      ),
    );
  }
}

// You can place the new widget here
class AnimatedTypingIndicator extends StatefulWidget {
  const AnimatedTypingIndicator({super.key});

  @override
  State<AnimatedTypingIndicator> createState() =>
      _AnimatedTypingIndicatorState();
}

class _AnimatedTypingIndicatorState extends State<AnimatedTypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(); // The controller will loop the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            // Create a staggered animation for each dot
            final dotAnimationValue = _controller.value * 3 - index;
            final clampedValue = dotAnimationValue.clamp(0.0, 1.0);

            // Use a curve to create a smooth "jump"
            final bounce = -Curves.easeOut.transform(clampedValue.abs()) * 6;

            return Transform.translate(
              offset: Offset(0, bounce),
              child: Text(
                '.',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
