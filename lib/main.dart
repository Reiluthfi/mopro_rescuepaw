import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'page/splash_onboarding_page.dart';

void main() {
  runApp(const RescuePawApp());
}

class RescuePawApp extends StatelessWidget {
  const RescuePawApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'RescuePaw',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0F766E)),
        scaffoldBackgroundColor: Colors.white,
      ),
      // Alur: Splash -> Login/Register -> MainShell
      home: const SplashOnboardingPage(),
    );
  }
}
