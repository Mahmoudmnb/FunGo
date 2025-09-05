class Offer {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final String location;
  final double originalPrice;
  final double discountedPrice;
  final int discountPercentage;
  final DateTime validUntil;
  final String offerType;
  final bool isActive;

  const Offer({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.location,
    required this.originalPrice,
    required this.discountedPrice,
    required this.discountPercentage,
    required this.validUntil,
    required this.offerType,
    required this.isActive,
  });
}
