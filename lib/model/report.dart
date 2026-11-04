import 'package:flutter/material.dart';

class Report {
  String id;
  String title;
  String description;
  String locationName;
  double distance; // dalam kilometer
  String type; // 'Dog' atau 'Cat'
  String status; // 'Pending', 'In progress', 'Rescued'
  String dateReported;
  double latitude;
  double longitude;

  Report({
    required this.id,
    required this.title,
    required this.description,
    required this.locationName,
    required this.distance,
    required this.type,
    required this.status,
    required this.dateReported,
    required this.latitude,
    required this.longitude,
  });
}

class AppColors {
  static const Color teal = Color(0xFF0F766E);
  static const Color amber = Color(0xFFFBBF24);
  static const Color bgLight = Color(0xFFF8FAFC);
  static const Color textMain = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF475569);

  static const Color pendingText = Color(0xFFB45309);
  static const Color pendingBg = Color(0xFFFFFBEB);
  static const Color progressText = Color(0xFF1D4ED8);
  static const Color progressBg = Color(0xFFEFF6FF);
  static const Color successText = Color(0xFF15803D);
}
