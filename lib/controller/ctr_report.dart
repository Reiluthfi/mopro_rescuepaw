import 'package:get/get.dart';

import '../model/report.dart';

class ReportController extends GetxController {
  // .obs membuat variabel menjadi reactive (didengarkan oleh View)
  var reports = <Report>[].obs;
  var isTakingTask = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadDummyData();
  }

  void _loadDummyData() {
    reports.assignAll([
      Report(
        id: 'R001',
        title: 'Kucing Liar Terluka',
        description: 'Kaki pincang.',
        latitude: -6.9740,
        longitude: 107.6300,
        status: 'menunggu',
      ),
      Report(
        id: 'R002',
        title: 'Anak Anjing Terjebak',
        description: 'Masuk selokan.',
        latitude: -6.9760,
        longitude: 107.6320,
        status: 'diproses',
      ),
    ]);
  }

  // Getter untuk memfilter data UI
  List<Report> get availableReports =>
      reports.where((r) => r.status == 'menunggu').toList();

  Future<void> ambilTugas(String id) async {
    isTakingTask.value = true;

    await Future.delayed(const Duration(seconds: 2)); // Simulasi API

    // Update status laporan di memori
    int index = reports.indexWhere((r) => r.id == id);
    if (index != -1) {
      reports[index].status = 'diproses';
      reports.refresh(); //update List
    }

    isTakingTask.value = false;

    Get.back();
    Get.snackbar('Sukses', 'Tugas berhasil diambil!');
  }
}
