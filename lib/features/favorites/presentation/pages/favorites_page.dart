import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/place_card.dart';
import '../../../home/methods/place_methods.dart';
import '../../../places/models/place_cart_model.dart';
import '../../../places/presentation/pages/place_page.dart';

class FavoritesPage extends ConsumerWidget {
  final List<PlaceCartModel> places;
  const FavoritesPage({
    super.key,
    required this.places,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final favorites = ref.watch(favoritesProvider);

    if (places.isEmpty) {
      return Center(
        child: Text(
          'لا توجد أماكن مفضلة حتى الآن',
          style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
        ),
      );
    }

    return StatefulBuilder(
      builder: (context, setState) => ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: places.length,
        itemBuilder: (context, index) {
          // final place = favorites[index];

          // final isFavorite = favorites.any((p) => p.id == place.id);
          PlaceCartModel place = places[index];
          return PlaceCard(
            place: place,
            type: 2,
            isFavorite: place.isFavorite,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PlacePage(id: place.id!)),
              );
            },
            onfav: () {
              // ref.read(favoritesProvider.notifier).removeFavorite(place);
              places.removeAt(index);
              setState(() {});
              addOrDeletePlaceFromFavorite(
                  context: context, id: place.id!, isFavorite: false);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.teal,
                  content: Text(
                    'تمت إزالة المكان من المفضلة',
                  ),
                ),
              );
            },
          );
          /*
          final place = favorites[index];
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    place.imageUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (_, __, ___) => Image.asset(
                          'assets/images/placeholder.png',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                  ),
                ),
                title: Text(
                  place.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(place.location),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                  onPressed: () {
                    ref.read(favoritesProvider.notifier).removeFavorite(place);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('تمت إزالة المكان من المفضلة'),
                      ),
                    );
                  },
                  tooltip: 'حذف من المفضلة',
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => PlacePage(place: place)),
                  );
                },
              ),
            ),
          );
        */
        },
      ),
    );
  }
}
