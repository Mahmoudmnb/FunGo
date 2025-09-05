class Trip {
  final String id;
  final String name;
  final String description;
  final DateTime createdAt;
  final List<String> placeIds;
  final bool isCompleted;

  const Trip({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.placeIds,
    this.isCompleted = false,
  });

  Trip copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? createdAt,
    List<String>? placeIds,
    bool? isCompleted,
  }) {
    return Trip(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      placeIds: placeIds ?? this.placeIds,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
