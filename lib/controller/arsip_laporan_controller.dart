import 'package:get/get.dart';

import '../model/laporan_model.dart';

class ArsipLaporanController extends GetxController {
  final reports = <LaporanModel>[].obs;
  final isLoading = false.obs;
  final isExporting = false.obs;

  @override
  void onInit() {
    super.onInit();
    _seedDummyData();
  }

  void _seedDummyData() {
    reports.assignAll(const [
      LaporanModel(
        title: 'Dog near Oak Street',
        date: '22 Oct 2026',
        status: StatusLaporan.pending,
        animalType: 'Dog',
        location: '-6.9740, 107.6300',
        description: 'Brown dog limping on the front left leg, near the bus stop.',
      ),
      LaporanModel(
        title: 'Cat at Riverside Park',
        date: '20 Oct 2026',
        status: StatusLaporan.inProgress,
        animalType: 'Cat',
        location: '-6.9760, 107.6320',
        description: 'Small orange cat, looks thin and scared under a bench.',
      ),
      LaporanModel(
        title: 'Dog near Central Market',
        date: '17 Oct 2026',
        status: StatusLaporan.rescued,
        animalType: 'Dog',
        location: '-6.9700, 107.6280',
        description: 'Puppy stuck in a drain, rescued by volunteers.',
      ),
      LaporanModel(
        title: 'Cat on Maple Avenue',
        date: '12 Oct 2026',
        status: StatusLaporan.rescued,
        animalType: 'Cat',
        location: '-6.9780, 107.6340',
        description: 'Injured cat on the roadside, taken to the clinic.',
      ),
    ]);
  }

  /// Called by the "Create report" form after a successful submit.
  void addReport(LaporanModel report) => reports.insert(0, report);

  /// Called when a volunteer takes the task in Beranda.
  void updateStatus(String id, StatusLaporan status) {
    final i = reports.indexWhere((r) => r.id == id);
    if (i != -1) reports[i] = reports[i].copyWith(status: status);
  }

  Future<void> loadReports() async {
    isLoading.value = true;
    try {
      // TODO: replace with REST API call, then reports.assignAll(result).
      // Existing in-memory reports (including newly created ones) are kept.
      await Future<void>.delayed(const Duration(milliseconds: 300));
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
