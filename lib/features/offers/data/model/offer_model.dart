import '../../domain/entities/offer.dart';

class OfferModel extends Offer {
  OfferModel({
    required super.id,
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.location,
    required super.originalPrice,
    required super.discountedPrice,
    required super.discountPercentage,
    required super.validUntil,
    required super.offerType,
    required super.isActive,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      location: json['location'],
      originalPrice: json['originalPrice'].toDouble(),
      discountedPrice: json['discountedPrice'].toDouble(),
      discountPercentage: json['discountPercentage'],
      validUntil: DateTime.parse(json['validUntil']),
      offerType: json['offerType'],
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'location': location,
      'originalPrice': originalPrice,
      'discountedPrice': discountedPrice,
      'discountPercentage': discountPercentage,
      'validUntil': validUntil.toIso8601String(),
      'offerType': offerType,
      'isActive': isActive,
    };
  }
}
