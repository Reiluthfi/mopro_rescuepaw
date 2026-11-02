import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/arsip_laporan_controller.dart';
import 'controller/buat_laporan_controller.dart';
import 'page/arsip_laporan_page.dart';
import 'page/buat_laporan_page.dart';

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
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0E7C6B)),
      ),
      initialRoute: '/arsip-laporan', // change to '/buat-laporan' for the other screen
      getPages: [
        GetPage(
          name: '/buat-laporan',
          page: () => const BuatLaporanPage(),
          binding: BuatLaporanBinding(),
        ),
        GetPage(
          name: '/arsip-laporan',
          page: () => const ArsipLaporanPage(),
          binding: ArsipLaporanBinding(),
        ),
      ],
    );
  }
}