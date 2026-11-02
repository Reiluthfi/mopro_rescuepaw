import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/arsip_laporan_controller.dart';
import '../model/laporan_model.dart';

class _C {
  static const background = Color(0xFFF8FAFC);
  static const surface = Colors.white;
  static const border = Color(0xFFE2E8F0);
  static const textPrimary = Color(0xFF1E293B);
  static const textSecondary = Color(0xFF64748B);
  static const accent = Color(0xFFFBBF24); // Export to PDF button
}

/// UI styling for each report status (kept in the page layer on purpose,
/// so the model stays free of Flutter UI dependencies).
extension _ReportStatusStyle on StatusLaporan {
  String get label => switch (this) {
        StatusLaporan.pending => 'Pending',
        StatusLaporan.inProgress => 'In progress',
        StatusLaporan.rescued => 'Rescued',
      };

  Color get foreground => switch (this) {
        StatusLaporan.pending => const Color(0xFFC2410C),
        StatusLaporan.inProgress => const Color(0xFF2563EB),
        StatusLaporan.rescued => const Color(0xFF16A34A),
      };

  Color get background => switch (this) {
        StatusLaporan.pending => const Color(0xFFFFF7E6),
        StatusLaporan.inProgress => const Color(0xFFEFF6FF),
        StatusLaporan.rescued => const Color(0xFFF0FDF4),
      };

  Color get borderColor => switch (this) {
        StatusLaporan.pending => const Color(0xFFFCD9A0),
        StatusLaporan.inProgress => const Color(0xFFBFDBFE),
        StatusLaporan.rescued => const Color(0xFFBBF7D0),
      };
}

class ArsipLaporanPage extends GetView<ArsipLaporanController> {
  const ArsipLaporanPage({super.key});

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
          'Arsip Laporan',
          style: TextStyle(
            color: _C.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              final items = controller.reports;
              return RefreshIndicator(
                onRefresh: controller.loadReports,
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 96),
                  itemCount: items.length + 1,
                  separatorBuilder: (_, i) =>
                      SizedBox(height: i == 0 ? 20 : 12),
                  itemBuilder: (context, index) {
                    if (index == 0) return const _Header();
                    return _ReportCard(item: items[index - 1]);
                  },
                ),
              );
            }),
            Positioned(
              right: 20,
              bottom: 16,
              child: Obx(() => _ExportButton(
                    isLoading: controller.isExporting.value,
                    onPressed: controller.exportToPdf,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your reports',
          style: TextStyle(
            color: _C.textPrimary,
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Track the animals you\'ve helped.',
          style: TextStyle(color: _C.textSecondary, fontSize: 14),
        ),
      ],
    );
  }
}

class _ReportCard extends StatelessWidget {
  const _ReportCard({required this.item});
  final LaporanModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _C.border),
      ),
      child: Row(
        children: [
          _Thumbnail(imageUrl: item.imageUrl),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _C.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.date,
                  style: const TextStyle(
                    color: _C.textSecondary,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                _StatusChip(status: item.status),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({this.imageUrl});
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    const size = 62.0;
    final placeholder = Container(
      color: const Color(0xFFE2E8F0),
      alignment: Alignment.center,
      child: const Icon(Icons.pets, color: _C.textSecondary),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: size,
        height: size,
        child: imageUrl == null
            ? placeholder
            : Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => placeholder,
              ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});
  final StatusLaporan status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: status.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: status.borderColor),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          color: status.foreground,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _ExportButton extends StatelessWidget {
  const _ExportButton({required this.onPressed, this.isLoading = false});
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: isLoading ? null : onPressed,
      icon: isLoading
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: _C.textPrimary,
              ),
            )
          : const Icon(Icons.download_rounded,
              size: 18, color: _C.textPrimary),
      label: const Text(
        'Export to PDF',
        style: TextStyle(
          color: _C.textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: FilledButton.styleFrom(
        backgroundColor: _C.accent,
        disabledBackgroundColor: _C.accent.withAlpha(150),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}