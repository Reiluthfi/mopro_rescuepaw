import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/adopsi_controller.dart';

class PageNotifikasi extends StatelessWidget {
  final AdopsiController controller = Get.find();

  PageNotifikasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications', style: TextStyle(color: Colors.black)), backgroundColor: Colors.white, iconTheme: const IconThemeData(color: Colors.black), elevation: 0),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Your updates', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const Text('Stay up to date with RescuePaw.', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 16),
          Obx(() => ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.daftarNotifikasi.length,
            itemBuilder: (context, index) {
              final notif = controller.daftarNotifikasi[index];
              return ListTile(
                leading: const Icon(Icons.notifications_outlined, color: Colors.green),
                title: Text(notif['judul'] ?? ''),
                subtitle: Text(notif['waktu'] ?? ''),
                contentPadding: EdgeInsets.zero,
              );
            },
          )),
        ],
      ),
    );
  }
}