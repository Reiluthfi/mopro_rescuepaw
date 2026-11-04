import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/buat_laporan_controller.dart';

class _C {
  static const background = Color(0xFFF8FAFC);
  static const surface = Colors.white;
  static const border = Color(0xFFE2E8F0);
  static const textPrimary = Color(0xFF1E293B);
  static const textSecondary = Color(0xFF64748B);
  static const primary = Color(0xFF0E7C6B);
}

class BuatLaporanPage extends GetView<BuatLaporanController> {
  const BuatLaporanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.background,
      appBar: AppBar(
        backgroundColor: _C.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              size: 20, color: _C.textPrimary),
          onPressed: Get.back,
        ),
        title: const Text(
          'Create Report',
          style: TextStyle(
            color: _C.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => _PhotoPlaceholder(
                    photoPath: controller.photoPath.value)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _OutlinedActionButton(
                        icon: Icons.photo_camera_outlined,
                        label: 'Camera',
                        onPressed: controller.pickFromCamera,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _OutlinedActionButton(
                        icon: Icons.image_outlined,
                        label: 'Gallery',
                        onPressed: controller.pickFromGallery,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const _FieldLabel('Location'),
                const SizedBox(height: 8),
                Obx(() => _LocationPicker(
                      label: controller.locationLabel.value,
                      onTap: controller.pickLocation,
                    )),
                const SizedBox(height: 24),
                const _FieldLabel('Animal type'),
                const SizedBox(height: 8),
                Obx(() => DropdownButtonFormField<String>(
                      value: controller.selectedAnimalType.value,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded,
                          color: _C.textPrimary),
                      decoration: _inputDecoration('Select animal type'),
                      items: controller.animalTypes
                          .map((t) =>
                              DropdownMenuItem(value: t, child: Text(t)))
                          .toList(),
                      onChanged: controller.setAnimalType,
                      validator: controller.validateAnimalType,
                    )),
                const SizedBox(height: 24),
                const _FieldLabel('Condition description'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: controller.descriptionController,
                  minLines: 4,
                  maxLines: 6,
                  textInputAction: TextInputAction.newline,
                  decoration: _inputDecoration(
                    'Describe the animal\'s condition and any visible injuries...',
                  ),
                  validator: controller.validateDescription,
                ),
                const SizedBox(height: 24),
                Obx(() => SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton(
                        onPressed: controller.isSubmitting.value
                            ? null
                            : controller.submit,
                        style: FilledButton.styleFrom(
                          backgroundColor: _C.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: controller.isSubmitting.value
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Submit Report',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    OutlineInputBorder border([Color color = _C.border]) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: color),
        );

    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: _C.textSecondary, fontSize: 14),
      filled: true,
      fillColor: _C.surface,
      contentPadding: const EdgeInsets.all(16),
      border: border(),
      enabledBorder: border(),
      focusedBorder: border(_C.primary),
      errorBorder: border(Colors.red.shade300),
      focusedErrorBorder: border(Colors.red.shade400),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: _C.textPrimary,
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _PhotoPlaceholder extends StatelessWidget {
  const _PhotoPlaceholder({this.photoPath});
  final String? photoPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 164,
      width: double.infinity,
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _C.border),
      ),
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      child: photoPath == null
          ? const Text(
              'Add a photo of the animal',
              style: TextStyle(
                color: _C.textPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle,
                    color: Color(0xFF16A34A), size: 36),
                const SizedBox(height: 8),
                Text(photoPath!, style: const TextStyle(fontSize: 12)),
              ],
            ),
    );
  }
}

class _OutlinedActionButton extends StatelessWidget {
  const _OutlinedActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 18, color: _C.textPrimary),
        label: Text(
          label,
          style: const TextStyle(
            color: _C.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: _C.surface,
          side: const BorderSide(color: _C.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

class _LocationPicker extends StatelessWidget {
  const _LocationPicker({required this.onTap, this.label});
  final String? label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 58,
        width: double.infinity,
        decoration: BoxDecoration(
          color: _C.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _C.border),
        ),
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: _C.surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.location_on_outlined,
                  size: 16, color: _C.textPrimary),
              const SizedBox(width: 6),
              Text(
                label ?? 'Tap to pick location',
                style: const TextStyle(
                  color: _C.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}