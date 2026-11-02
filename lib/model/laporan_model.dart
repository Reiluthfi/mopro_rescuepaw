enum StatusLaporan { pending, inProgress, rescued }

class LaporanModel {
  const LaporanModel({
    required this.title,
    required this.date,
    required this.status,
    this.imageUrl,
  });

  final String title;
  final String date;
  final StatusLaporan status;
  final String? imageUrl;
}