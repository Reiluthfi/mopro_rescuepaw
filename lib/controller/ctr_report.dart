import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../model/report.dart';

class ReportController extends GetxController {
  var reports = <Report>[].obs;

  // UI States
  var isMapView = false.obs;
  var searchQuery = ''.obs;
  var selectedFilter = 'All animals'.obs;
  var isTakingTask = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadDummyData();
  }

  void _loadDummyData() {
    reports.assignAll([
      Report(
        id: '1',
        title: 'Dog near Oak Street',
        locationName: 'Oak Street',
        distance: 0.4,
        type: 'Dog',
        status: 'Pending',
        dateReported: '22 Oct 2026',
        latitude: -6.9740,
        longitude: 107.6300,
        description: 'anjing yang terluka, berada di dekat jalan Oak.',
      ),
      Report(
        id: '2',
        title: 'Cat at Riverside Park',
        locationName: 'Riverside Park',
        distance: 0.8,
        type: 'Cat',
        status: 'In progress',
        dateReported: '20 Oct 2026',
        latitude: -6.9750,
        longitude: 107.6310,
        description: 'dekat pintu masuk gerbang.',
      ),
      Report(
        id: '3',
        title: 'Dog on Pine Avenue',
        locationName: 'Pine Avenue',
        distance: 1.2,
        type: 'Dog',
        status: 'In progress',
        dateReported: '17 Oct 2026',
        latitude: -6.9720,
        longitude: 107.6280,
        description: 'bawah carrier',
      ),
    ]);
  }

  List<Report> get filteredReports {
    return reports.where((r) {
      final matchesSearch =
          r.title.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
          r.locationName.toLowerCase().contains(
            searchQuery.value.toLowerCase(),
          );
      bool matchesFilter = true;
      if (selectedFilter.value == 'Dogs') matchesFilter = r.type == 'Dog';
      if (selectedFilter.value == 'Cats') matchesFilter = r.type == 'Cat';
      if (selectedFilter.value == 'Pending')
        matchesFilter = r.status == 'Pending';

      return matchesSearch && matchesFilter;
    }).toList();
  }

  // OpenStreetMap Markers
  List<Marker> get markers {
    return filteredReports.map((report) {
      return Marker(
        width: 40.0,
        height: 40.0,
        point: LatLng(report.latitude, report.longitude),
        child: GestureDetector(
          onTap: () => Get.snackbar('Location', report.locationName),
          child: Icon(
            Icons.location_pin,
            size: 40,
            color: report.status == 'Pending'
                ? AppColors.pendingText
                : AppColors.progressText,
          ),
        ),
      );
    }).toList();
  }

  List<Report> get myTasks =>
      reports.where((r) => r.status == 'In progress').toList();

  Future<void> takeReport(String id) async {
    isTakingTask.value = true;
    await Future.delayed(const Duration(seconds: 1));
    int index = reports.indexWhere((r) => r.id == id);
    if (index != -1) {
      reports[index].status = 'In progress';
      reports.refresh();
      Get.back();
    }
    isTakingTask.value = false;
  }

  void updateTaskToDone(String id) {
    int index = reports.indexWhere((r) => r.id == id);
    if (index != -1) {
      reports[index].status = 'Rescued';
      reports.refresh();
    }
  }

  void addReport(Report newReport) {
    reports.add(newReport);
  }
}
