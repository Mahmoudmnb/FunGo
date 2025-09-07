import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants.dart';
import '../../../../shared/widgets/place_card.dart';
import '../../../favorites/methods/favorite_method.dart';
import '../../../favorites/presentation/pages/favorites_page.dart';
import '../../../offers/presentation/pages/offers_page.dart';
import '../../../places/models/place_cart_model.dart';
import '../../../places/models/sales_places_model.dart';
import '../../../places/presentation/pages/place_page.dart';
import '../../../places/presentation/widgets/logo_widget.dart';
import '../../../trip/methods/trip_methods.dart';
import '../../../trip/models/trip_model.dart';
import '../../../trip/presentation/pages/trip_page.dart';
import '../../methods/place_methods.dart';
import '../providers/home_providers.dart';
import '../widgets/filter_sheet.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late Future<List<PlaceCartModel>?> getPlacesMethod;
  late Future<List<PlaceCartModel>?> getFavoriteMethod;
  late Future<List<SalesPlacesModel>?> getSalesMethod;
  late Future<List<TripModel>?> getTripMethod;
  String selectedPlace = 'الكل';
  bool location = false;
  bool cheapest = false;
  bool rating = false;
  bool offers = false;
  String? longitude;
  String? latitude;

  @override
  void initState() {
    getPlacesMethod = getPlacesWithFilter(
        context: context,
        filter: getFilterText(
            cheapest: cheapest,
            rating: rating,
            offers: offers,
            cityName: selectedPlace));
    getFavoriteMethod = getFavorites(context: context);
    getSalesMethod = getSales(context: context);
    getTripMethod = getTrips(context: context);

    super.initState();
  }

  int _pageIndex = 0;

  final List<String> _provinces = const [
    'دمشق',
    'ريف دمشق',
    'حمص',
    'حماة',
    'حلب',
    'اللاذقية',
    'طرطوس',
    'إدلب',
    'دير الزور',
    'الحسكة',
    'الرقة',
    'السويداء',
    'درعا',
    'القنيطرة',
    'تدمر',
  ];

  @override
  Widget build(BuildContext context) {
    // final filteredPlaces = ref.watch(filteredPlacesProvider);

    // final favorites = ref.watch(favoritesProvider);

    // ✅ أيقونات البوتوم ناف
    final navItems = <Widget>[
      const Icon(Icons.home, size: 30, color: Colors.white),
      const Icon(Icons.favorite, size: 30, color: Colors.white),
      const Icon(Icons.local_offer, size: 30, color: Colors.white), // العروض
      const Icon(Icons.airplane_ticket, size: 30, color: Colors.white), // رحلتي
    ];

    // ✅ الصفحات المرتبطة
    final pages = [
      FutureBuilder(
        future: getPlacesMethod,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Expanded(
                child: Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasData) {
            return _buildPlacesList(snapshot.data!);
          } else {
            return SizedBox(
              height: 600,
              child: IconButton(
                  onPressed: () {
                    getPlacesMethod = getPlacesWithFilter(
                        context: context,
                        filter: getFilterText(
                            cheapest: cheapest,
                            rating: rating,
                            offers: offers,
                            cityName: selectedPlace));
                    setState(() {});
                  },
                  icon: const Icon(Icons.replay_outlined)),
            );
          }
        },
      ),
      FutureBuilder(
        future: getFavoriteMethod,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return FavoritesPage(places: snapshot.data!);
          } else {
            return Center(
              child: IconButton(
                  onPressed: () {
                    getFavoriteMethod = getFavorites(context: context);
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
      FutureBuilder(
        future: getSalesMethod,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return OffersPage(sales: snapshot.data!);
          } else {
            return Center(
              child: IconButton(
                  onPressed: () {
                    getSalesMethod = getSales(context: context);
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
      FutureBuilder(
        future: getTripMethod,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return TripPage(trips: snapshot.data!);
          } else {
            return Center(
              child: IconButton(
                  onPressed: () {
                    getSalesMethod = getSales(context: context);
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.replay_outlined,
                    size: 30,
                  )),
            );
          }
        },
      )
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const LogoWidget(),
        backgroundColor: Colors.grey[100],
        centerTitle: true,
        actions: [
          _pageIndex == 0
              ? Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: FilterIconButton(onPressed: () async {
                    await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      useSafeArea: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      builder: (_) => FilterBottomSheet(
                        cheapest: cheapest,
                        location: location,
                        offers: offers,
                        rating: rating,
                        onFilter: (c, r, o, l, long, lat) async {
                          cheapest = c;
                          rating = r;
                          offers = o;
                          location = l;
                          longitude = long;
                          latitude = lat;
                          if (context.mounted) {
                            getPlacesMethod = getPlacesWithFilter(
                                context: context,
                                filter: getFilterText(
                                    cheapest: cheapest,
                                    rating: rating,
                                    offers: offers,
                                    cityName: selectedPlace,
                                    latitude: latitude,
                                    longitude: longitude));
                            setState(() {});
                          }
                        },
                      ),
                    );
                    // بعد الإغلاق: الفلترة تتحدث تلقائياً
                  }),
                )
              : const SizedBox.shrink(),
        ],
      ),

      // ✅ بوتوم نافيجشن مع 4 أيقونات
      bottomNavigationBar: Directionality(
        textDirection: TextDirection.rtl,
        child: CurvedNavigationBar(
          backgroundColor: Colors.grey.shade100,
          color: Colors.teal.shade700,
          buttonBackgroundColor: Colors.teal.shade900,
          height: 60,
          items: navItems,
          index: _pageIndex,
          onTap: (index) {
            if (index != _pageIndex) {
              switch (index) {
                case 0:
                  getPlacesMethod =
                      getPlacesWithFilter(context: context, filter: '');
                  break;
                case 1:
                  getFavoriteMethod = getFavorites(context: context);
                  break;
                case 2:
                  getSalesMethod = getSales(context: context);
                  break;
                default:
                  getTripMethod = getTrips(context: context);
              }
              setState(() {
                _pageIndex = index;
              });
            }
          },
        ),
      ),

      // ✅ عرض الصفحة المطلوبة
      body: Column(
        children: [
          if (_pageIndex == 0) ...[
            const SizedBox(height: 12),
            _buildProvinceFilter(context, (String text) {
              getPlacesMethod =
                  getPlacesWithFilter(context: context, filter: text);
              setState(() {});
            }),
            pages[_pageIndex]
          ] else
            Expanded(child: pages[_pageIndex]),
        ],
      ),
    );
  }

  Widget _buildProvinceFilter(BuildContext context, Function(String) onTap) {
    final selectedProvince = ref.watch(selectedProvinceProvider);
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: _provinces.length + 1,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            if (index == 0) {
              return ChoiceChip(
                label: const Text('الكل'),
                selected: selectedProvince == null,
                selectedColor: Colors.teal.shade700,
                backgroundColor: Colors.teal.shade200,
                labelStyle: TextStyle(
                  color: selectedProvince == null
                      ? Colors.white
                      : Colors.teal.shade900,
                ),
                onSelected: (_) {
                  onTap(getFilterText(
                      cheapest: cheapest,
                      rating: rating,
                      offers: offers,
                      cityName: selectedPlace));
                  ref.read(selectedProvinceProvider.notifier).state = null;
                },
              );
            }
            final province = _provinces[index - 1];
            return ChoiceChip(
              label: Text(province),
              selected: selectedProvince == province,
              selectedColor: Colors.teal.shade700,
              backgroundColor: Colors.teal.shade200,
              labelStyle: TextStyle(
                color: selectedProvince == province
                    ? Colors.white
                    : Colors.teal.shade900,
              ),
              onSelected: (_) {
                onTap(getEnglishCityName(province));
                ref.read(selectedProvinceProvider.notifier).state = province;
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildPlacesList(List<PlaceCartModel> places) {
    if (places.isEmpty) {
      return SizedBox(
        height: 600,
        child: Center(
          child: Text(
            'لا توجد أماكن مطابقة للفلترة',
            style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
          ),
        ),
      );
    }

    return StatefulBuilder(
      builder: (context, setState) => SizedBox(
        height: 620,
        width: MediaQuery.sizeOf(context).width,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 12),
          shrinkWrap: true,
          itemCount: places.length,
          itemBuilder: (context, index) {
            final place = places[index];

            // final favorites = ref.watch(favoritesProvider);
            // final isFavorite = favorites.any((p) => p.id == place.id);
            return PlaceCard(
              type: 1,
              place: place,
              isFavorite: place.isFavorite,
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PlacePage(id: place.id!)),
                );
              },
              onfav: () async {
                // ref.read(favoritesProvider.notifier).toggleFavorite(place);
                final msg = place.isFavorite
                    ? 'تمت إزالة المكان من المفضلة'
                    : 'تمت إضافة المكان إلى المفضلة';
                place.isFavorite = !place.isFavorite;
                setState(() {});
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(msg)));
                await addOrDeletePlaceFromFavorite(
                    context: context,
                    id: place.id!,
                    isFavorite: place.isFavorite);
              },
            );
          },
        ),
      ),
    );
  }
}
