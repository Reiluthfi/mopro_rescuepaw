import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'page/splash_onboarding_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'RescuePaw',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const SplashOnboardingPage(),
    );
  }
}
