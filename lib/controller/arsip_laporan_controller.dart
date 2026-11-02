import 'package:get/get.dart';

import '../model/laporan_model.dart';

class ArsipLaporanController extends GetxController {
  final reports = <LaporanModel>[].obs;
  final isLoading = false.obs;
  final isExporting = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadReports();
  }

  Future<void> loadReports() async {
    isLoading.value = true;
    try {
      // TODO: replace with REST API call
      await Future<void>.delayed(const Duration(milliseconds: 300));
      reports.assignAll(const [
        LaporanModel(
          title: 'Dog near Oak Street',
          date: '22 Oct 2026',
          status: StatusLaporan.pending,
        ),
        LaporanModel(
          title: 'Cat at Riverside Park',
          date: '20 Oct 2026',
          status: StatusLaporan.inProgress,
        ),
        LaporanModel(
          title: 'Dog near Central Market',
          date: '17 Oct 2026',
          status: StatusLaporan.rescued,
        ),
        LaporanModel(
          title: 'Cat on Maple Avenue',
          date: '12 Oct 2026',
          status: StatusLaporan.rescued,
        ),
      ]);
    } catch (_) {
      Get.snackbar('Error', 'Failed to load your reports.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> exportToPdf() async {
    isExporting.value = true;
    try {
      // TODO: generate PDF from `reports` (e.g. `pdf` + `printing` packages)
      await Future<void>.delayed(const Duration(milliseconds: 500));
      Get.snackbar('Export', 'PDF exported successfully.');
    } catch (_) {
      Get.snackbar('Error', 'Failed to export PDF.');
    } finally {
      isExporting.value = false;
    }
  }
}

class ArsipLaporanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArsipLaporanController>(() => ArsipLaporanController());
  }
}