import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'place_state.dart';

class PlaceNotifier extends StateNotifier<PlaceState> {
  final Connectivity _connectivity;
  StreamSubscription<ConnectivityResult>? _subscription;

  PlaceNotifier(this._connectivity) : super(PlaceState.initial()) {
    _checkConnectivity();
    _subscription = _connectivity.onConnectivityChanged.listen((result) {
      state = state.copyWith(isOnline: result != ConnectivityResult.none);
    }) as StreamSubscription<ConnectivityResult>?;
  }

  Future<void> _checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    state = state.copyWith(isOnline: result != ConnectivityResult.none);
  }

  void updateRating(double rating) {
    state = state.copyWith(rating: rating);
  }

  void addComment(String text) {
    if (text.trim().isEmpty) return;
    final newComments = [
      {
        'userName': 'مستخدم جديد',
        'content': text,
        'date': DateTime.now(),
      },
      ...state.comments,
    ];
    state = state.copyWith(comments: newComments);
  }

  void updatePage(int page) {
    state = state.copyWith(currentPage: page);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

final placeProvider =
StateNotifierProvider<PlaceNotifier, PlaceState>((ref) {
  return PlaceNotifier(Connectivity());
});
