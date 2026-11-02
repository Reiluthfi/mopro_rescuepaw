import 'package:get/get.dart';

class AdopsiController extends GetxController {
  var daftarAdopsi = [
    {'id': '1', 'nama': 'Buddy', 'jenis': 'Dog', 'umur': '2 years', 'ras': 'Labrador mix', 'status': 'Available'},
    {'id': '2', 'nama': 'Luna', 'jenis': 'Cat', 'umur': '1 year', 'ras': 'Domestic', 'status': 'Available'},
  ].obs;

  var daftarPengajuan = [
    {'idPengajuan': 'R1', 'pelamar': 'Emma Wilson', 'hewan': 'Buddy', 'tanggal': '26 Oct 2026', 'status': 'Pending', 'deskripsi': 'I work from home and have a fenced yard.'},
  ].obs;

  var daftarNotifikasi = [
    {'judul': 'Emma Wilson applied for Buddy.', 'waktu': 'Today - 9:30 AM'},
    {'judul': 'Buddy\'s adoption listing is live.', 'waktu': 'Today - 9:00 AM'},
  ].obs;

  void tambahAdopsi(String nama, String ras, String umur, String deskripsi) {
    daftarAdopsi.add({
      'id': DateTime.now().toString(),
      'nama': nama.isNotEmpty ? nama : 'Tanpa Nama',
      'ras': ras.isNotEmpty ? ras : 'Unknown',
      'umur': umur.isNotEmpty ? umur : '-',
      'status': 'Available',
    });
    tambahNotifikasi("Katalog adopsi $nama sudah tayang.");
    Get.back();
    Get.snackbar('Sukses', 'Data hewan dipublikasikan', snackPosition: SnackPosition.BOTTOM);
  }

  void kirimPengajuan(String namaHewan, String alasan) {
    daftarPengajuan.add({
      'idPengajuan': DateTime.now().toString(),
      'pelamar': 'Pengguna Saat Ini',
      'hewan': namaHewan,
      'tanggal': 'Baru saja',
      'status': 'Pending',
      'deskripsi': alasan,
    });
    tambahNotifikasi("Kamu mengajukan adopsi untuk $namaHewan.");
    Get.back();
    Get.back();
    Get.snackbar('Sukses', 'Pengajuan berhasil dikirim', snackPosition: SnackPosition.BOTTOM);
  }

  void responPengajuan(String idPengajuan, String namaHewan, bool disetujui) {
    var index = daftarPengajuan.indexWhere((r) => r['idPengajuan'] == idPengajuan);
    if (index != -1) {
      daftarPengajuan[index]['status'] = disetujui ? 'Accepted' : 'Rejected';
      daftarPengajuan.refresh();
      tambahNotifikasi("Pengajuan adopsi untuk $namaHewan telah ${disetujui ? 'Diterima' : 'Ditolak'}.");
    }
  }

  void tambahNotifikasi(String pesan) {
    daftarNotifikasi.insert(0, {'judul': pesan, 'waktu': 'Baru saja'});
  }
}