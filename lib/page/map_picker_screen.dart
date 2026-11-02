import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Komponen standalone yang nanti dipanggil oleh form Modul 2
class MapPickerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pilih Lokasi')),
      body: const Center(child: Text('Map View Placeholder')),
      floatingActionButton: FloatingActionButton.extended(
        // Menutup halaman sambil me-return Map/JSON koordinat
        // Ini adalah jalur komunikasi untuk mengirim titik lokasi kembali ke pemanggilnya
        onPressed: () => Get.back(result: {'lat': -6.9740, 'lng': 107.6300}),
        label: const Text('Pilih Lokasi Ini'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
