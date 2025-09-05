import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../data/model/place_model.dart';
import '../providers/place_provider.dart';
import '../../../favorites/presentation/providers/favorites_provider.dart';
import '../../../trip/presentation/pages/trip_page.dart';
import '../../../offers/presentation/pages/offers_page.dart';
import '../widgets/place_image_slider.dart';


class PlacePage extends ConsumerStatefulWidget {
  final PlaceModel place;
  const PlacePage({super.key, required this.place});

  @override
  ConsumerState<PlacePage> createState() => _PlacePageState();
}

class _PlacePageState extends ConsumerState<PlacePage> {
  final PageController _pageController = PageController();
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _pageController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(placeProvider);
    final notifier = ref.read(placeProvider.notifier);

    final favorites = ref.watch(favoritesProvider);
    final isFavorite = favorites.any((p) => p.id == widget.place.id);
    // final offers = widget.place.offers ?? [];

    if (!state.isOnline) {
      return const Center(child: Text("❌ لا يوجد اتصال بالإنترنت"));
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 📸 الصور
              PlaceImageSlider(
                imageUrls: widget.place.imageUrls,
                controller: _pageController,
                currentPage: state.currentPage,
                onPageChanged: (page) => notifier.updatePage(page),
              ),

              // ❤️ مفضلة + ✈️ رحلتي + 🟠 عروض
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey),
                    onPressed: () {
                      ref.read(favoritesProvider.notifier).toggleFavorite(widget.place);
                    },
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const TripPage()));
                    },
                    icon: const Icon(Icons.airplane_ticket),
                    label: const Text("رحلتي"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // if (offers.isNotEmpty) {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(builder: (_) => OffersPage(placeId: widget.place.id)),
                      //   );
                      // } else {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(content: Text('⚠️ لا يوجد عروض لهذا المكان')),
                      //   );
                      // }
                    },
                    icon: const Icon(Icons.local_offer),
                    label: const Text("العروض"),
                  ),
                ],
              ),

              // ℹ️ تفاصيل
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.place.name,
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.teal.shade900)),
                    const SizedBox(height: 8),
                    Text(widget.place.description),
                    const SizedBox(height: 16),

                    // ⭐ تقييم
                    RatingBar.builder(
                      initialRating: state.rating,
                      minRating: 1,
                      maxRating: 5,
                      itemSize: 28,
                      itemBuilder: (_, __) => const Icon(Icons.star, color: Colors.amber),
                      onRatingUpdate: (rating) => notifier.updateRating(rating),
                    ),

                    const SizedBox(height: 16),

                    // 💬 تعليقات
                    Row(
                      children: [
                        const Text("💬 القصص"),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            if (_commentController.text.isNotEmpty) {
                              notifier.addComment(_commentController.text);
                              _commentController.clear();
                            }
                          },
                          child: const Text("إضافة قصة"),
                        )
                      ],
                    ),
                    ...state.comments.map((c) => ListTile(
                      title: Text(c['userName']),
                      subtitle: Text(c['content']),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
