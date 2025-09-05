import '../../domain/entities/offer.dart';

class OfferModel extends Offer {
  OfferModel({
    required int id,
    required String name,
    required String description,
    required String imageUrl,
    required String location,
    required double originalPrice,
    required double discountedPrice,
    required int discountPercentage,
    required DateTime validUntil,
    required String offerType,
    required bool isActive,
  }) : super(
         id: id,
         name: name,
         description: description,
         imageUrl: imageUrl,
         location: location,
         originalPrice: originalPrice,
         discountedPrice: discountedPrice,
         discountPercentage: discountPercentage,
         validUntil: validUntil,
         offerType: offerType,
         isActive: isActive,
       );

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
