import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../favorites/methods/favorite_method.dart';
import '../../../home/methods/place_methods.dart';
import '../../../offers/presentation/pages/offers_page.dart';
import '../../../trip/methods/trip_methods.dart';
import '../../../trip/models/trip_model.dart';
import '../../../trip/presentation/pages/trip_page.dart';
import '../../models/place_model.dart';
import '../../models/sales_places_model.dart';
import '../widgets/favorite_icon.dart';
import '../widgets/place_image_slider.dart';
import '../widgets/story_section.dart';

class PlacePage extends ConsumerStatefulWidget {
  final int id;
  const PlacePage({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<PlacePage> createState() => _PlacePageState();
}

class _PlacePageState extends ConsumerState<PlacePage> {
  final PageController _pageController = PageController();
  final TextEditingController _commentController = TextEditingController();
  Future<PlaceModel?>? getFavoriteMethod;
  bool isLoading = false;

  @override
  void dispose() {
    _pageController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getFavoriteMethod = getPlace(context: context, id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final state = ref.watch(placeProvider);
    // final notifier = ref.read(placeProvider.notifier);

    // final favorites = ref.watch(favoritesProvider);
    // final isFavorite = favorites.any((p) => p.id == place.id);
    // final offers = place.offers ?? [];

    // if (!state.isOnline) {
    //   return const Center(child: Text("❌ لا يوجد اتصال بالإنترنت"));
    // }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(),
      body: FutureBuilder(
        future: getFavoriteMethod,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            PlaceModel place = snapshot.data!;
            return SingleChildScrollView(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 📸 الصور
                    PlaceImageSlider(
                      imageUrls: place.images ?? [],
                      controller: _pageController,
                      currentPage: 0, //state.currentPage,
                      onPageChanged: (page) {
                        // notifier.updatePage(page);
                      },
                    ),

                    // ❤️ مفضلة + ✈️ رحلتي + 🟠 عروض
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FavoriteIcon(place: place),
                        StatefulBuilder(
                          builder: (context, setState) => ElevatedButton.icon(
                            onPressed: () async {
                              isLoading = true;
                              setState(() {});
                              List<TripModel>? trips =
                                  await getTrips(context: context);
                              isLoading = false;
                              setState(() {});
                              if (trips != null && context.mounted) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            TripPage(trips: trips)));
                              }
                            },
                            icon: isLoading
                                ? const SizedBox.shrink()
                                : const Icon(Icons.airplane_ticket),
                            label: isLoading
                                ? const CircularProgressIndicator()
                                : const Text("رحلتي"),
                          ),
                        ),
                        StatefulBuilder(
                          builder: (context, setState) => ElevatedButton.icon(
                            onPressed: () async {
                              // if (offers.isNotEmpty) {
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(builder: (_) => OffersPage(placeId: place.id)),
                              //   );
                              // } else {
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     const SnackBar(content: Text('⚠️ لا يوجد عروض لهذا المكان')),
                              //   );
                              // }

                              isLoading = true;
                              setState(() {});
                              List<SalesPlacesModel>? sales = await getSales(
                                  context: context, placeId: place.id);
                              isLoading = false;
                              setState(() {});
                              if (sales != null && context.mounted) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            OffersPage(sales: sales)));
                              }
                            },
                            icon: isLoading
                                ? const SizedBox.shrink()
                                : const Icon(Icons.local_offer),
                            label: isLoading
                                ? const CircularProgressIndicator()
                                : const Text("العروض"),
                          ),
                        ),
                      ],
                    ),

                    // ℹ️ تفاصيل
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(place.name ?? '',
                              style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal.shade900)),
                          const SizedBox(height: 8),
                          Text(place.description ?? ''),
                          const SizedBox(height: 16),

                          // ⭐ تقييم
                          RatingBar.builder(
                            initialRating: place.reviewAvarge!,
                            minRating: 1,
                            maxRating: 5,
                            itemSize: 28,
                            itemBuilder: (_, __) =>
                                const Icon(Icons.star, color: Colors.amber),
                            onRatingUpdate: (rating) {
                              place.reviewAvarge = rating;
                              setState(() {});
                              ratePlaces(
                                  context: context,
                                  id: place.id!,
                                  rating: rating);
                              // notifier.updateRating(rating);
                            },
                          ),

                          const SizedBox(height: 16),

                          // 💬 تعليقات
                          StorySection(place: place)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: IconButton(
                  onPressed: () {
                    getFavoriteMethod =
                        getPlace(context: context, id: widget.id);
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.replay_outlined,
                    size: 30,
                  )),
            );
          }
        },
      ),
    );
  }
}
