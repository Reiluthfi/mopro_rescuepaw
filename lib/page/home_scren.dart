import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/ctr_report.dart';
import 'report_detail_screen.dart';
import 'profile_page.dart';

class HomeScreen extends StatelessWidget {
  final ReportController controller = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Beranda Laporan'),
          actions: [
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Get.to(() => const ProfilePage());
              },
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.list), text: 'Daftar'),
              Tab(icon: Icon(Icons.map), text: 'Peta'),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Obx(() {
              final list = controller.availableReports;
              if (list.isEmpty)
                return const Center(child: Text('Semua tugas sudah diambil'));

              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final report = list[index];
                  return ListTile(
                    leading: const Icon(Icons.pets, color: Colors.orange),
                    title: Text(report.title),
                    subtitle: Text(report.description),
                    onTap: () => Get.to(
                      () => ReportDetailScreen(report: report),
                    ), // Navigasi GetX
                  );
                },
              );
            }),

            const Center(child: Text('Map View Placeholder')),
          ],
        ),
      ),
    );
  }
}
