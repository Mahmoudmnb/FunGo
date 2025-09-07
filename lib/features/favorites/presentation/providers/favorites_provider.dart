import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../places/data/model/place_model.dart';

class FavoritesNotifier extends StateNotifier<List<PlaceModelTemp>> {
  FavoritesNotifier() : super([]);

  void addFavorite(PlaceModelTemp place) {
    if (!state.any((p) => p.id == place.id)) {
      state = [...state, place];
    }
  }

  void removeFavorite(PlaceModelTemp place) {
    state = state.where((p) => p.id != place.id).toList();
  }

  void toggleFavorite(PlaceModelTemp place) {
    if (state.any((p) => p.id == place.id)) {
      removeFavorite(place);
    } else {
      addFavorite(place);
    }
  }

  bool isFavorite(PlaceModelTemp place) => state.any((p) => p.id == place.id);
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<PlaceModelTemp>>(
  (ref) => FavoritesNotifier(),
);
