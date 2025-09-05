import '../../data/model/place_model.dart';

class PlaceState {
  final bool isOnline;
  final double rating;
  final List<Map<String, dynamic>> comments;
  final int currentPage;

  const PlaceState({
    required this.isOnline,
    required this.rating,
    required this.comments,
    required this.currentPage,
  });

  factory PlaceState.initial() {
    return const PlaceState(
      isOnline: true,
      rating: 0,
      comments: [],
      currentPage: 0,
    );
  }

  PlaceState copyWith({
    bool? isOnline,
    double? rating,
    List<Map<String, dynamic>>? comments,
    int? currentPage,
  }) {
    return PlaceState(
      isOnline: isOnline ?? this.isOnline,
      rating: rating ?? this.rating,
      comments: comments ?? this.comments,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
