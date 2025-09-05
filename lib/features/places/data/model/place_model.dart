import '../../domain/entities/place.dart';

class PlaceModel extends Place {
  PlaceModel({
    required int id,
    required String name,
    required String description,
    required List<String> imageUrls,
    required String location,
    required List<Map<String, Object>> activities,
    double? rating,
    String? province,
  }) : super(
    id: id,
    name: name,
    description: description,
    imageUrls: imageUrls,
    location: location,
    activities: activities,
    rating: rating,
    province: province,
  );

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrls: (json['imageUrls'] as List<dynamic>).cast<String>(),
      location: json['location'] as String,
      activities: (json['activities'] as List<dynamic>)
          .map((a) => Map<String, Object>.from(a as Map))
          .toList(),
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : null,
      province: json['province'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrls': imageUrls,
      'location': location,
      'activities': activities,
      'rating': rating,
      'province': province,
    };
  }
}
