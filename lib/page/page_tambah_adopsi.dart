import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/adopsi_controller.dart';

class PageTambahAdopsi extends StatelessWidget {
  final AdopsiController controller = Get.find();
  final TextEditingController txtNama = TextEditingController();
  final TextEditingController txtRas = TextEditingController();
  final TextEditingController txtUmur = TextEditingController();
  final TextEditingController txtDeskripsi = TextEditingController();

  PageTambahAdopsi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Adoption', style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade400)),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.upload_file, size: 40, color: Colors.grey),
                SizedBox(height: 8),
                Text('Upload photo')
              ],
            ),
          ),
          const SizedBox(height: 16),
          TextField(controller: txtNama, decoration: const InputDecoration(labelText: 'Animal name')),
          const SizedBox(height: 16),
          TextField(controller: txtRas, decoration: const InputDecoration(labelText: 'Breed')),
          const SizedBox(height: 16),
          TextField(controller: txtUmur, decoration: const InputDecoration(labelText: 'Age')),
          const SizedBox(height: 16),
          TextField(controller: txtDeskripsi, maxLines: 4, decoration: const InputDecoration(labelText: 'Behavior description')),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(vertical: 16)),
            onPressed: () {
              if(txtNama.text.isNotEmpty) {
                controller.tambahAdopsi(txtNama.text, txtRas.text, txtUmur.text, txtDeskripsi.text);
              }
            },
            child: const Text('Publish Adoption', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }
}