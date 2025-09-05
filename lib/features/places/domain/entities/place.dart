class Place {
  final int id;
  final String name;
  final String description;
  final List<String> imageUrls;
  final String location;
  final List<Map<String, Object>> activities;

  // الحقول الجديدة
  final double? rating;   // للتقييم (مثلاً 4.5)
  final String? province; // اسم المحافظة (مثلاً: حلب)

  const Place({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrls,
    required this.location,
    required this.activities,
    this.rating,
    this.province,
  });
}
