import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../places/data/model/place_model.dart';


class FavoritesNotifier extends StateNotifier<List<PlaceModel>> {
  FavoritesNotifier() : super([]);

  void addFavorite(PlaceModel place) {
    if (!state.any((p) => p.id == place.id)) {
      state = [...state, place];
    }
  }

  void removeFavorite(PlaceModel place) {
    state = state.where((p) => p.id != place.id).toList();
  }

  void toggleFavorite(PlaceModel place) {
    if (state.any((p) => p.id == place.id)) {
      removeFavorite(place);
    } else {
      addFavorite(place);
    }
  }

  bool isFavorite(PlaceModel place) => state.any((p) => p.id == place.id);
}

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<PlaceModel>>(
      (ref) => FavoritesNotifier(),
);
