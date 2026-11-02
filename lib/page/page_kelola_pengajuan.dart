import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/adopsi_controller.dart';

class PageKelolaPengajuan extends StatelessWidget {
  final AdopsiController controller = Get.find();

  PageKelolaPengajuan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Requests', style: TextStyle(color: Colors.black)), backgroundColor: Colors.white, iconTheme: const IconThemeData(color: Colors.black), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Adoption requests', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Obx(() => Text('${controller.daftarPengajuan.where((r) => r['status'] == 'Pending').length} pending requests for your animals.', style: const TextStyle(color: Colors.grey))),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: controller.daftarPengajuan.length,
                itemBuilder: (context, index) {
                  final req = controller.daftarPengajuan[index];
                  
                  final String idPengajuan = req['idPengajuan'] ?? '';
                  final String pelamar = req['pelamar'] ?? 'Pelamar Tanpa Nama';
                  final String hewan = req['hewan'] ?? 'Hewan';
                  final String tanggal = req['tanggal'] ?? '-';
                  final String status = req['status'] ?? 'Pending';
                  final String deskripsi = req['deskripsi'] ?? '';

                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(pelamar, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              Chip(label: Text(status, style: TextStyle(color: status == 'Pending' ? Colors.orange : Colors.grey))),
                            ],
                          ),
                          Text('For $hewan - $tanggal', style: const TextStyle(color: Colors.grey)),
                          const SizedBox(height: 8),
                          Text(deskripsi),
                          const SizedBox(height: 16),
                          if (status == 'Pending') Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                  onPressed: () => controller.responPengajuan(idPengajuan, hewan, true),
                                  child: const Text('Accept', style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(foregroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
                                  onPressed: () => controller.responPengajuan(idPengajuan, hewan, false),
                                  child: const Text('Reject'),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              )),
            )
          ],
        ),
      ),
    );
  }
}