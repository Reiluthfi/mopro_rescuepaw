import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/adopsi_controller.dart';
import 'page_tambah_adopsi.dart';
import 'page_detail_hewan.dart';
import 'page_kelola_pengajuan.dart';
import 'page_notifikasi.dart';

class PageKatalogAdopsi extends StatelessWidget {
  final AdopsiController controller = Get.isRegistered<AdopsiController>()
      ? Get.find<AdopsiController>()
      : Get.put(AdopsiController());

  PageKatalogAdopsi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adoption Catalog', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () => Get.to(() => PageNotifikasi()),
          ),
          TextButton(
            onPressed: () => Get.to(() => PageTambahAdopsi()),
            child: const Text('+ Add', style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Find a companion', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const Text('Give a rescued animal a loving home.', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search by name or breed',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Ready for adoption', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: Obx(() => GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: controller.daftarAdopsi.length,
                itemBuilder: (context, index) {
                  final hewan = controller.daftarAdopsi[index];
                  return InkWell(
                    onTap: () => Get.to(() => PageDetailHewan(dataHewan: hewan)),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                              ),
                              child: const Icon(Icons.pets, size: 50, color: Colors.grey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(hewan['nama'] ?? 'Tanpa Nama', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                Text('${hewan['umur'] ?? '-'} • ${hewan['jenis'] ?? ''}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )),
            ),
            Center(
              child: TextButton(
                onPressed: () => Get.to(() => PageKelolaPengajuan()),
                child: const Text('Manage adoption requests', style: TextStyle(color: Colors.green)),
              ),
            )
          ],
        ),
      ),
    );
  }
}