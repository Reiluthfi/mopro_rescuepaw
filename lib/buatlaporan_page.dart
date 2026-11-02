import 'package:flutter/material.dart';

/// UI only: camera, gallery and map picking are exposed as callbacks/TODOs.

class _C {
  static const background = Color(0xFFF8FAFC);
  static const surface = Colors.white;
  static const border = Color(0xFFE2E8F0);
  static const textPrimary = Color(0xFF1E293B);
  static const textSecondary = Color(0xFF64748B);
  static const primary = Color(0xFF0E7C6B);
}

class BuatlaporanPage extends StatefulWidget {
  const BuatlaporanPage({super.key});

  @override
  State<BuatlaporanPage> createState() => _BuatlaporanPageState();
}

class _BuatlaporanPageState extends State<BuatlaporanPage> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();

  static const _animalTypes = ['Dog', 'Cat', 'Other'];

  String? _selectedAnimalType;
  String? _photoPath; // TODO: set from image_picker (camera / gallery)
  String? _locationLabel; // TODO: set from map picker

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _pickFromCamera() {
    // TODO: ImagePicker().pickImage(source: ImageSource.camera)
  }

  void _pickFromGallery() {
    // TODO: ImagePicker().pickImage(source: ImageSource.gallery)
  }

  void _pickLocation() {
    // TODO: open Google Maps picker and store the selected coordinates
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    final missingPhoto = _photoPath == null;
    final missingLocation = _locationLabel == null;

    if (!isValid || missingPhoto || missingLocation) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            missingPhoto
                ? 'Please add a photo of the animal.'
                : missingLocation
                    ? 'Please pick the animal\'s location.'
                    : 'Please complete the required fields.',
          ),
        ),
      );
      return;
    }
    // TODO: send report through REST API
  }

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
          onPressed: () => Navigator.maybePop(context),
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
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _PhotoPlaceholder(photoPath: _photoPath),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _OutlinedActionButton(
                        icon: Icons.photo_camera_outlined,
                        label: 'Camera',
                        onPressed: _pickFromCamera,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _OutlinedActionButton(
                        icon: Icons.image_outlined,
                        label: 'Gallery',
                        onPressed: _pickFromGallery,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const _FieldLabel('Location'),
                const SizedBox(height: 8),
                _LocationPicker(label: _locationLabel, onTap: _pickLocation),
                const SizedBox(height: 24),
                const _FieldLabel('Animal type'),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedAnimalType,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded,
                      color: _C.textPrimary),
                  decoration: _inputDecoration('Select animal type'),
                  items: _animalTypes
                      .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                      .toList(),
                  onChanged: (v) => setState(() => _selectedAnimalType = v),
                  validator: (v) =>
                      v == null ? 'Please select an animal type' : null,
                ),
                const SizedBox(height: 24),
                const _FieldLabel('Condition description'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _descriptionController,
                  minLines: 4,
                  maxLines: 6,
                  textInputAction: TextInputAction.newline,
                  decoration: _inputDecoration(
                    'Describe the animal\'s condition and any visible injuries...',
                  ),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Please describe the animal\'s condition'
                      : null,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton(
                    onPressed: _submit,
                    style: FilledButton.styleFrom(
                      backgroundColor: _C.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Submit Report',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
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
          : const SizedBox.shrink(), // TODO: Image.file(File(photoPath!))
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
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 6,
                offset: const Offset(0, 2),
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