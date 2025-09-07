import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/favorites_provider.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    if (favorites.isEmpty) {
      return Center(
        child: Text(
          'لا توجد أماكن مفضلة حتى الآن',
          style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final place = favorites[index];

        final isFavorite = favorites.any((p) => p.id == place.id);
        return null;
        // return PlaceCard(
        //   place: place,
        //   type: 2,
        //   isFavorite: isFavorite,
        //   onTap: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (_) => PlacePage(place: place)),
        //     );
        //   },
        //   onfav: () {
        //     ref.read(favoritesProvider.notifier).removeFavorite(place);
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       const SnackBar(content: Text('تمت إزالة المكان من المفضلة')),
        //     );
        //   },
        // );
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
    );
  }
}
