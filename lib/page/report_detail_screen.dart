import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/ctr_report.dart';
import '../model/report.dart';

class ReportDetailScreen extends StatelessWidget {
  final Report report;
  // Ambil controller yang sudah di-inject di HomeScreen
  final ReportController controller = Get.find<ReportController>();

  ReportDetailScreen({required this.report});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Laporan')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              report.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('STATUS: ${report.status.toUpperCase()}'),
            const SizedBox(height: 16),
            Text(report.description),
            const Spacer(),

            if (report.status == 'menunggu')
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    // Disable tombol jika isTakingTask bernilai true
                    onPressed: controller.isTakingTask.value
                        ? null
                        : () => controller.ambilTugas(report.id),
                    child: controller.isTakingTask.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Ambil Tugas'),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
