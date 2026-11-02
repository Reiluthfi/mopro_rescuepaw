import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/adopsi_controller.dart';

class PageFormPengajuan extends StatelessWidget {
  final String namaHewan;
  final AdopsiController controller = Get.find();
  final TextEditingController txtAlasan = TextEditingController();

  PageFormPengajuan({super.key, required this.namaHewan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adoption Request Form', style: TextStyle(color: Colors.black)), 
        backgroundColor: Colors.white, 
        iconTheme: const IconThemeData(color: Colors.black), 
        elevation: 0
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('A home for $namaHewan', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextField(
            controller: txtAlasan,
            maxLines: 5,
            decoration: const InputDecoration(
              labelText: 'Why would you like to adopt?',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: const Size(double.infinity, 50)),
            onPressed: () {
              if(txtAlasan.text.isNotEmpty) {
                controller.kirimPengajuan(namaHewan, txtAlasan.text);
              }
            },
            child: const Text('Submit', style: TextStyle(color: Colors.white, fontSize: 16)),
          )
        ],
      ),
    );
  }
}