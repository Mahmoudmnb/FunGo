import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../favorites/presentation/providers/favorites_provider.dart';
import '../../../places/data/model/place_model.dart';

import '../../../../shared/widgets/place_card.dart';
import '../../../places/presentation/pages/place_page.dart';
import '../../../favorites/presentation/pages/favorites_page.dart';
import '../../../places/presentation/widgets/logo_widget.dart';
import '../providers/home_providers.dart';
import '../widgets/filter_sheet.dart';

// ✅ إضافات جديدة
import '../../../offers/presentation/pages/offers_page.dart';
import '../../../trip/presentation/pages/trip_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
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
    final filteredPlaces = ref.watch(filteredPlacesProvider);
    final favorites = ref.watch(favoritesProvider);

    // ✅ أيقونات البوتوم ناف
    final navItems = <Widget>[
      const Icon(Icons.home, size: 30, color: Colors.white),
      const Icon(Icons.favorite, size: 30, color: Colors.white),
      const Icon(Icons.local_offer, size: 30, color: Colors.white), // العروض
      const Icon(Icons.airplane_ticket, size: 30, color: Colors.white), // رحلتي
    ];

    // ✅ الصفحات المرتبطة
    final pages = [
      _buildPlacesList(filteredPlaces),
      const FavoritesPage(),
      const OffersPage(),
      const TripPage(),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: LogoWidget(),
        backgroundColor: Colors.grey[100],
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FilterIconButton(onPressed: () async {
              await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                useSafeArea: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                builder: (_) => FilterBottomSheet(),
              );
              // بعد الإغلاق: الفلترة تتحدث تلقائياً
            }),
          ),
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
            setState(() {
              _pageIndex = index;
            });
          },
        ),
      ),

      // ✅ عرض الصفحة المطلوبة
      body: Column(
        children: [
          if (_pageIndex == 0) ...[
            const SizedBox(height: 12),
            _buildProvinceFilter(context),
            Expanded(child: pages[_pageIndex]),
          ] else ...[
            Expanded(child: pages[_pageIndex]),
          ],
        ],
      ),
    );
  }

  Widget _buildProvinceFilter(BuildContext context) {
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
                ref.read(selectedProvinceProvider.notifier).state = province;
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildPlacesList(List<PlaceModel> places) {
    if (places.isEmpty) {
      return Center(
        child: Text(
          'لا توجد أماكن مطابقة للفلترة',
          style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: places.length,
      itemBuilder: (context, index) {
        final place = places[index];

        final favorites = ref.watch(favoritesProvider);
        final isFavorite = favorites.any((p) => p.id == place.id);
        return PlaceCard(
          type: 1,
          place: place,
          isFavorite: isFavorite,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => PlacePage(place: place)),
            );
          },
          onfav: () {
            ref.read(favoritesProvider.notifier).toggleFavorite(place);
            final msg = isFavorite
                ? 'تمت إزالة المكان من المفضلة'
                : 'تمت إضافة المكان إلى المفضلة';
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(msg)));
          },
        );
      },
    );
  }
}
