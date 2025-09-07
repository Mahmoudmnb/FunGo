import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants.dart';
import '../../../places/models/sales_places_model.dart';
import '../../data/model/offer_model.dart';
import '../pages/offer_details_page.dart';
import '../widgets/offer_card.dart';

class OffersPage extends StatefulWidget {
  final List<SalesPlacesModel> sales;
  const OffersPage({
    super.key,
    required this.sales,
  });

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> _offerTypes = [
    'الكل',
    'رحلة سياحية',
    'جولة تاريخية',
    'مغامرة طبيعية',
    'رحلة بحرية',
  ];

  final List<String> _locations = [
    'الكل',
    'دمشق',
    'حمص',
    'دير الزور',
    'حلب',
    'اللاذقية',
  ];

  // All offers
  late final List<OfferModel> _allOffers;

  // Filters
  String? _selectedOfferType;
  String? _selectedLocation;

  late List<SalesPlacesModel> sales;

  // Filtered offers
  late List<OfferModel> _filteredOffers;

  @override
  void initState() {
    super.initState();
    sales = widget.sales;
    _allOffers = [
      OfferModel(
        id: 1,
        name: 'رحلة إلى سوق الحميدية',
        description:
            'استمتع برحلة مميزة إلى أحد أقدم الأسواق التاريخية في دمشق مع وجبة غداء مجانية.',
        imageUrl: 'https://picsum.photos/id/1011/600/400',
        location: 'دمشق',
        originalPrice: 50000,
        discountedPrice: 35000,
        discountPercentage: 30,
        validUntil: DateTime.now().add(const Duration(days: 15)),
        offerType: 'رحلة سياحية',
        isActive: true,
      ),
      OfferModel(
        id: 2,
        name: 'زيارة قلعة الحصن',
        description:
            'اكتشف التاريخ العريق في قلعة الحصن مع دليل سياحي متخصص ووجبة عشاء.',
        imageUrl: 'https://picsum.photos/id/1012/600/400',
        location: 'حمص',
        originalPrice: 75000,
        discountedPrice: 55000,
        discountPercentage: 27,
        validUntil: DateTime.now().add(const Duration(days: 8)),
        offerType: 'جولة تاريخية',
        isActive: true,
      ),
      OfferModel(
        id: 3,
        name: 'محمية شرقي دير الزور',
        description:
            'مغامرة طبيعية في المحمية مع رحلة قارب وتصوير احترافي مجاني.',
        imageUrl: 'https://picsum.photos/id/1013/600/400',
        location: 'دير الزور',
        originalPrice: 60000,
        discountedPrice: 42000,
        discountPercentage: 30,
        validUntil: DateTime.now().add(const Duration(days: 12)),
        offerType: 'مغامرة طبيعية',
        isActive: true,
      ),
      OfferModel(
        id: 4,
        name: 'جولة في حلب القديمة',
        description:
            'اكتشف عراقة مدينة حلب مع زيارة القلعة والمساجد التاريخية.',
        imageUrl: 'https://picsum.photos/id/1014/600/400',
        location: 'حلب',
        originalPrice: 80000,
        discountedPrice: 56000,
        discountPercentage: 30,
        validUntil: DateTime.now().add(const Duration(days: 20)),
        offerType: 'جولة تاريخية',
        isActive: true,
      ),
      OfferModel(
        id: 5,
        name: 'شاطئ اللاذقية',
        description:
            'استمتع بالبحر الأبيض المتوسط مع رحلة صيد وتناول المأكولات البحرية.',
        imageUrl: 'https://picsum.photos/id/1015/600/400',
        location: 'اللاذقية',
        originalPrice: 45000,
        discountedPrice: 31500,
        discountPercentage: 30,
        validUntil: DateTime.now().add(const Duration(days: 6)),
        offerType: 'رحلة بحرية',
        isActive: true,
      ),
    ];

    _filteredOffers = List.from(_allOffers);
    _searchController.addListener(_filterOffers);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterOffers() {
    final searchQuery = _searchController.text.toLowerCase();

    setState(() {
      sales = sales.where((offer) {
        // final matchesSearch = offer.name.toLowerCase().contains(searchQuery) ||
        //     offer.description.toLowerCase().contains(searchQuery) ||
        //     offer.location.toLowerCase().contains(searchQuery);

        // final matchesType = _selectedOfferType == null ||
        //     _selectedOfferType == 'الكل' ||
        //     offer.offerType == _selectedOfferType;

        final matchesLocation = _selectedLocation == null ||
            _selectedLocation == 'الكل' ||
            offer.placeName == getEnglishCityName(_selectedLocation ?? 'الكل');

        return matchesLocation;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'عروض',
          style: GoogleFonts.cairo(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal.shade700,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search and filter section
          // Container(
          //   padding: const EdgeInsets.all(16),
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.grey.withOpacity(0.1),
          //         blurRadius: 4,
          //         offset: const Offset(0, 2),
          //       ),
          //     ],
          //   ),
          //   child: Column(
          //     children: [
          //       const SizedBox(height: 16),

          //       const SizedBox(height: 12),

          //       // Location filter
          //       Row(
          //         children: [
          //           Expanded(
          //             child: SingleChildScrollView(
          //               scrollDirection: Axis.horizontal,
          //               reverse: true,
          //               child: Row(
          //                 children: _locations.reversed.map((location) {
          //                   final isSelected = _selectedLocation == location ||
          //                       (_selectedLocation == null &&
          //                           location == 'الكل');
          //                   return Padding(
          //                     padding: const EdgeInsets.only(right: 8),
          //                     child: FilterChip(
          //                       label: Text(
          //                         location,
          //                         style: GoogleFonts.cairo(
          //                           color: isSelected
          //                               ? Colors.white
          //                               : Colors.teal.shade700,
          //                           fontSize: 12,
          //                         ),
          //                       ),
          //                       selected: isSelected,
          //                       selectedColor: Colors.teal.shade600,
          //                       backgroundColor: Colors.white,
          //                       onSelected: (_) {
          //                         _selectedLocation =
          //                             location == 'الكل' ? null : location;
          //                         _filterOffers();
          //                       },
          //                     ),
          //                   );
          //                 }).toList(),
          //               ),
          //             ),
          //           ),
          //           const SizedBox(width: 12),
          //           Text(
          //             ' : الموقع',
          //             style: GoogleFonts.cairo(
          //               fontSize: 14,
          //               fontWeight: FontWeight.w600,
          //               color: Colors.grey.shade700,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),

          // Offers list
          Expanded(
            child: sales.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 80,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'لا توجد عروض متاحة',
                          style: GoogleFonts.cairo(
                            fontSize: 18,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'جرب تغيير معايير البحث',
                          style: GoogleFonts.cairo(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: sales.length,
                    itemBuilder: (context, index) {
                      // final offer = _filteredOffers[index];
                      const isFavorite = false;

                      return OfferCard(
                        sales: sales[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  OfferDetailsPage(sales: sales[index]),
                            ),
                          );
                        },
                        onFavorite: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('تم إضافة العرض إلى المفضلة'),
                              backgroundColor: Colors.teal.shade600,
                            ),
                          );
                        },
                        isFavorite: isFavorite,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
