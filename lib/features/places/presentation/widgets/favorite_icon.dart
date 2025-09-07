import 'package:flutter/material.dart';

import '../../../home/methods/place_methods.dart';
import '../../models/place_model.dart';

class FavoriteIcon extends StatefulWidget {
  final PlaceModel place;
  const FavoriteIcon({
    super.key,
    required this.place,
  });

  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  late PlaceModel place;
  @override
  void initState() {
    place = widget.place;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        place.isFavorite ? Icons.favorite : Icons.favorite_border,
        color: place.isFavorite ? Colors.red : Colors.grey,
      ),
      onPressed: () {
        addOrDeletePlaceFromFavorite(
            context: context, id: place.id!, isFavorite: !place.isFavorite);
        place.isFavorite = !place.isFavorite;
        setState(() {});
        // ref
        //     .read(favoritesProvider.notifier)
        //     .toggleFavorite(place);
      },
    );
  }
}
