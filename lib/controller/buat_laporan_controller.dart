import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../model/laporan_model.dart';
import '../model/report.dart';
import 'ctr_report.dart';
import '../page/map_picker_screen.dart';
import 'arsip_laporan_controller.dart';

class BuatLaporanController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();

  final animalTypes = const ['Dog', 'Cat', 'Other'];

  // Reactive state
  final selectedAnimalType = RxnString();
  final photoPath = RxnString(); // TODO: set from image_picker
  final locationLabel = RxnString(); // TODO: set from map picker
  final isSubmitting = false.obs;

  double? _lat;
  double? _lng;

  void pickFromCamera() {
    photoPath.value = 'dummy_camera_photo.jpg'; // TODO: ImagePicker camera
  }

  void pickFromGallery() {
    photoPath.value = 'dummy_gallery_photo.jpg'; // TODO: ImagePicker gallery
  }

  Future<void> pickLocation() async {
    final result = await Get.to<LatLng>(() => const MapPickerScreen());
    if (result != null) {
      _lat = result.latitude;
      _lng = result.longitude;
      locationLabel.value =
          '${result.latitude.toStringAsFixed(4)}, ${result.longitude.toStringAsFixed(4)}';
    }
  }

  void setAnimalType(String? value) => selectedAnimalType.value = value;

  String? validateAnimalType(String? value) =>
      value == null ? 'Please select an animal type' : null;

  String? validateDescription(String? value) =>
      (value == null || value.trim().isEmpty)
      ? 'Please describe the animal\'s condition'
      : null;

  Future<void> submit() async {
    final isValid = formKey.currentState?.validate() ?? false;

    if (photoPath.value == null) {
      _showError('Please add a photo of the animal.');
      return;
    }
    if (locationLabel.value == null) {
      _showError('Please pick the animal\'s location.');
      return;
    }
    if (!isValid) {
      _showError('Please complete the required fields.');
      return;
    }

    isSubmitting.value = true;
    try {
      // TODO: send report through REST API
      await Future<void>.delayed(const Duration(milliseconds: 500));

      // Save the report into the archive so it shows up there.
      final type = selectedAnimalType.value ?? 'Other';
      final archive = Get.isRegistered<ArsipLaporanController>()
          ? Get.find<ArsipLaporanController>()
          : Get.put(ArsipLaporanController());
      final id = 'R${DateTime.now().millisecondsSinceEpoch}';
      final title = '$type at ${locationLabel.value}';
      final description = descriptionController.text.trim();

      archive.addReport(
        LaporanModel(
          id: id,
          title: title,
          date: _formatDate(DateTime.now()),
          status: StatusLaporan.pending,
          animalType: type,
          description: description,
          location: locationLabel.value,
          photoPath: photoPath.value,
          latitude: _lat,
          longitude: _lng,
        ),
      );

      // Also publish it to Beranda so volunteers can take the task.
      final home = Get.isRegistered<ReportController>()
          ? Get.find<ReportController>()
          : Get.put(ReportController());
      home.addReport(
        Report(
          id: id,
          title: title,
          description: description,
          latitude: _lat ?? 0,
          longitude: _lng ?? 0,
          status: 'menunggu',
          locationName: locationLabel.value ?? 'Unknown',
          distance: 0.0,
          type: type,
          dateReported: _formatDate(DateTime.now()),
        ),
      );

      Get.back();
      Get.snackbar(
        'Success',
        'Report submitted. It is now on Beranda and in your archive.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    } catch (_) {
      _showError('Failed to submit the report. Please try again.');
    } finally {
      isSubmitting.value = false;
    }
  }

  String _formatDate(DateTime d) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${d.day} ${months[d.month - 1]} ${d.year}';
  }

  void _showError(String message) {
    Get.snackbar(
      'Incomplete report',
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }

  @override
  void onClose() {
    descriptionController.dispose();
    super.onClose();
  }
}

class BuatLaporanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuatLaporanController>(() => BuatLaporanController());
  }
}
