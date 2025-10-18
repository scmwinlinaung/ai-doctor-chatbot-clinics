import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:clinics/core/widgets/loading_overlay.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.go('/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/images/logo.jpg", fit: BoxFit.cover),
          ),
          const Center(child: LoadingWidget()),
        ],
      ),
    );
  }
}
