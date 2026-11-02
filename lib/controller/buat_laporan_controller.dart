import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuatLaporanController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();

  final animalTypes = const ['Dog', 'Cat', 'Other'];

  // Reactive state
  final selectedAnimalType = RxnString();
  final photoPath = RxnString(); // TODO: set from image_picker
  final locationLabel = RxnString(); // TODO: set from map picker
  final isSubmitting = false.obs;

  void pickFromCamera() {
    // TODO: ImagePicker().pickImage(source: ImageSource.camera)
  }

  void pickFromGallery() {
    // TODO: ImagePicker().pickImage(source: ImageSource.gallery)
  }

  void pickLocation() {
    // TODO: open Google Maps picker, then set locationLabel.value
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
      Get.back();
    } catch (_) {
      _showError('Failed to submit the report. Please try again.');
    } finally {
      isSubmitting.value = false;
    }
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