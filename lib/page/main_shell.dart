import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/adopsi_controller.dart';
import '../controller/arsip_laporan_controller.dart';
import '../controller/buat_laporan_controller.dart';
import '../controller/ctr_report.dart';
import 'arsip_laporan_page.dart';
import 'buat_laporan_page.dart';
import 'home_screen.dart';
import 'page_katalog_adopsi.dart';
import 'profile_page.dart';

/// Halaman utama setelah login: bottom navigation + tombol Report.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    // AdopsiController dipakai bersama oleh banyak halaman adopsi.
    if (!Get.isRegistered<AdopsiController>()) {
      Get.put(AdopsiController());
    }
    // Shared by Beranda and the create-report form.
    if (!Get.isRegistered<ReportController>()) {
      Get.put(ReportController(), permanent: true);
    }
    // Shared by the archive page AND the create-report form.
    if (!Get.isRegistered<ArsipLaporanController>()) {
      Get.put(ArsipLaporanController(), permanent: true);
    }
    _pages = [HomeScreen(), PageKatalogAdopsi(), const ProfilePage()];
  }

  void _openReportMenu() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.add_a_photo_outlined),
              title: const Text('Create report'),
              onTap: () {
                Navigator.pop(ctx);
                Get.to(
                  () => const BuatLaporanPage(),
                  binding: BuatLaporanBinding(),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.inventory_2_outlined),
              title: const Text('Report archive'),
              onTap: () {
                Navigator.pop(ctx);
                Get.to(() => const ArsipLaporanPage());
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openReportMenu,
        backgroundColor: const Color(0xFF0F766E),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.pets),
        label: const Text('Report'),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Adopt',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
