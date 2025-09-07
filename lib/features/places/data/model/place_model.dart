import '../../domain/entities/place.dart';

class PlaceModelTemp extends Place {
  PlaceModelTemp({
    required super.id,
    required super.name,
    required super.description,
    required super.imageUrls,
    required super.location,
    required super.activities,
    super.rating,
    super.province,
  });

  factory PlaceModelTemp.fromJson(Map<String, dynamic> json) {
    return PlaceModelTemp(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrls: (json['imageUrls'] as List<dynamic>).cast<String>(),
      location: json['location'] as String,
      activities: (json['activities'] as List<dynamic>)
          .map((a) => Map<String, Object>.from(a as Map))
          .toList(),
      rating:
          json['rating'] != null ? (json['rating'] as num).toDouble() : null,
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
