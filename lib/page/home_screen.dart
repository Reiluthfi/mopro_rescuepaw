import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../controller/ctr_report.dart';
import '../model/report.dart';
import 'report_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  final ReportController controller = Get.put(ReportController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'RescuePaw',
          style: TextStyle(
            color: AppColors.textMain,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Obx(
              () => Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    _buildToggleBtn(
                      'List',
                      Icons.list,
                      !controller.isMapView.value,
                    ),
                    _buildToggleBtn(
                      'Map',
                      Icons.map,
                      controller.isMapView.value,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  onChanged: (val) => controller.searchQuery.value = val,
                  decoration: InputDecoration(
                    hintText: 'Search by animal or location',
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColors.textSecondary,
                    ),
                    filled: true,
                    fillColor: AppColors.bgLight,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Obx(
                    () => Row(
                      children: ['All animals', 'Dogs', 'Cats', 'Pending'].map((
                        filter,
                      ) {
                        bool isSelected =
                            controller.selectedFilter.value == filter;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ChoiceChip(
                            label: Text(
                              filter,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.textMain,
                              ),
                            ),
                            selectedColor: AppColors.teal,
                            backgroundColor: AppColors.bgLight,
                            selected: isSelected,
                            showCheckmark: false,
                            onSelected: (_) =>
                                controller.selectedFilter.value = filter,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isMapView.value) {
                return FlutterMap(
                  options: const MapOptions(
                    initialCenter: LatLng(-6.9740, 107.6300),
                    initialZoom: 14.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.rescuepaw',
                    ),
                    MarkerLayer(markers: controller.markers),
                  ],
                );
              }

              final list = controller.filteredReports;
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final report = list[index];
                  return GestureDetector(
                    onTap: () =>
                        Get.to(() => ReportDetailScreen(report: report)),
                    child: Card(
                      color: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.grey.shade200),
                      ),
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.pets,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    report.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: AppColors.textMain,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${report.locationName} • ${report.distance} km away',
                                    style: const TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: report.status == 'Pending'
                                          ? AppColors.pendingBg
                                          : AppColors.progressBg,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      report.status,
                                      style: TextStyle(
                                        color: report.status == 'Pending'
                                            ? AppColors.pendingText
                                            : AppColors.progressText,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleBtn(String text, IconData icon, bool isActive) {
    return GestureDetector(
      onTap: () => controller.isMapView.value = (text == 'Map'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? AppColors.teal : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: isActive ? Colors.white : AppColors.textSecondary,
            ),
            const SizedBox(width: 4),
            Text(
              text,
              style: TextStyle(
                color: isActive ? Colors.white : AppColors.textSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
