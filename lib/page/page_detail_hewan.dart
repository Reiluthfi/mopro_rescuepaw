import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'page_form_pengajuan.dart';

class PageDetailHewan extends StatelessWidget {
  final Map<String, dynamic> dataHewan;

  const PageDetailHewan({super.key, required this.dataHewan});

  @override
  Widget build(BuildContext context) {
    final String namaHewan = dataHewan['nama'] ?? 'Tanpa Nama';
    final String statusHewan = dataHewan['status'] ?? 'Available';
    final String rasHewan = dataHewan['ras'] ?? 'Unknown';
    final String umurHewan = dataHewan['umur'] ?? '-';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Animal Detail', style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 250,
            width: double.infinity,
            color: Colors.grey[300],
            child: const Icon(Icons.pets, size: 100, color: Colors.grey),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(namaHewan, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                    Chip(label: Text(statusHewan, style: const TextStyle(color: Colors.green)), backgroundColor: Colors.green[50]),
                  ],
                ),
                Text('$rasHewan • $umurHewan', style: const TextStyle(fontSize: 16, color: Colors.grey)),
                const SizedBox(height: 16),
                Text('About $namaHewan', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Text('Friendly and playful. Enjoys walks and is looking for a safe, loving home.', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () => Get.to(() => PageFormPengajuan(namaHewan: namaHewan)),
              child: const Text('Apply to Adopt', style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          )
        ],
      ),
    );
  }
}