enum StatusLaporan { pending, inProgress, rescued }

class LaporanModel {
  const LaporanModel({
    this.id,
    required this.title,
    required this.date,
    required this.status,
    this.imageUrl,
    this.animalType,
    this.description,
    this.location,
    this.photoPath,
    this.latitude,
    this.longitude,
  });

  /// Same id as the matching `Report` in Beranda (null for old dummy data).
  final String? id;
  final String title;
  final String date;
  final StatusLaporan status;
  final String? imageUrl;

  // Detail fields (shown in the archive detail page)
  final String? animalType;
  final String? description;
  final String? location;
  final String? photoPath; // local file path of the photo taken/picked
  final double? latitude;
  final double? longitude;

  LaporanModel copyWith({StatusLaporan? status}) => LaporanModel(
        id: id,
        title: title,
        date: date,
        status: status ?? this.status,
        imageUrl: imageUrl,
        animalType: animalType,
        description: description,
        location: location,
        photoPath: photoPath,
        latitude: latitude,
        longitude: longitude,
      );
}
