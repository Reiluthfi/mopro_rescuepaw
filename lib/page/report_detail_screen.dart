import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/ctr_report.dart';
import '../model/report.dart';

class ReportDetailScreen extends StatelessWidget {
  final Report report;
  final ReportController controller = Get.find<ReportController>();

  ReportDetailScreen({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Report Detail',
          style: TextStyle(color: AppColors.textMain),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: AppColors.textMain),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            color: Colors.grey[300],
            child: const Icon(Icons.pets, size: 64, color: Colors.white),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  report.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textMain,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.pendingBg,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        report.status,
                        style: const TextStyle(
                          color: AppColors.pendingText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      'Reported ${report.dateReported}',
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Condition description',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textMain,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  report.description,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Location',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textMain,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${report.locationName}. ${report.distance} km',
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          const Spacer(),
          if (report.status == 'Pending')
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(
                () => SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: controller.isTakingTask.value
                        ? null
                        : () => controller.takeReport(report.id),
                    child: controller.isTakingTask.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Take Report',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
