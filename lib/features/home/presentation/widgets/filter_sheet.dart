// lib/features/home/widgets/filter_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';

import '../../methods/place_methods.dart';

class FilterIconButton extends StatelessWidget {
  const FilterIconButton({super.key, this.onPressed});
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.teal.shade700,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onPressed,
        child: const Padding(
          padding: EdgeInsets.all(12),
          child: Icon(Icons.tune_rounded, size: 22, color: Colors.white),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class FilterBottomSheet extends ConsumerWidget {
  bool location;
  bool cheapest;
  bool rating;
  bool offers;
  bool isLoading = false;
  Function(bool, bool, bool, bool, String?, String?) onFilter;
  FilterBottomSheet({
    super.key,
    required this.onFilter,
    required this.cheapest,
    required this.location,
    required this.offers,
    required this.rating,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final rating = ref.watch(selectedRatingProvider);
    // final budget = ref.watch(selectedBudgetProvider);
    // final location = ref.watch(selectedLocationProvider);
    // final selectedActivity = ref.watch(selectedActivityProvider);
    // final all = ref.watch(placesProvider);

    // جمع أسماء الانشطة المتاحة لاستخدامها في chips
    // final activities = <String>{};
    // for (final p in all) {
    //   for (final a in p.activities) {
    //     final name = (a['name'] ?? '').toString().trim();
    //     if (name.isNotEmpty) activities.add(name);
    //   }
    // }
    // final activityList = activities.toList();

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Container(
              //   width: 40,
              //   height: 5,
              //   decoration: BoxDecoration(
              //     color: Colors.grey.shade300,
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              // ),
              // const SizedBox(height: 16),

              // // Rating slider without the "bubble" value indicator
              // Row(
              //   children: [
              //     SizedBox(
              //         width: 80,
              //         child: Text('التقييم (الأدنى)',
              //             style: Theme.of(context).textTheme.titleMedium)),
              //     Expanded(
              //       child: SliderTheme(
              //         data: SliderTheme.of(context).copyWith(
              //           showValueIndicator: ShowValueIndicator.never,
              //           trackHeight: 4,
              //           thumbShape:
              //               const RoundSliderThumbShape(enabledThumbRadius: 9),
              //         ),
              //         child: Slider(
              //           value: (rating ?? 0),
              //           min: 0,
              //           max: 5,
              //           divisions: 5,
              //           label: '', // نخليها فارغة حتى لا تظهر
              //           activeColor: Colors.teal.shade700,
              //           onChanged: (v) => ref
              //               .read(selectedRatingProvider.notifier)
              //               .state = (v == 0) ? null : v,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),

              // const SizedBox(height: 8),

              // // Budget slider: يعرض الحد الأقصى للميزانية، والفرز حسب الميزانية سيتم تطبيقه في provider
              // Row(
              //   children: [
              //     SizedBox(
              //         width: 80,
              //         child: Text('ميزانيتي (أقصى)',
              //             style: Theme.of(context).textTheme.titleMedium)),
              //     Expanded(
              //       child: SliderTheme(
              //         data: SliderTheme.of(context).copyWith(
              //           showValueIndicator: ShowValueIndicator.never,
              //           trackHeight: 4,
              //           thumbShape:
              //               const RoundSliderThumbShape(enabledThumbRadius: 9),
              //         ),
              //         child: Slider(
              //           value: (budget ?? 0),
              //           min: 0,
              //           max: 500,
              //           divisions: 20,
              //           label: '',
              //           activeColor: Colors.teal.shade700,
              //           onChanged: (v) => ref
              //               .read(selectedBudgetProvider.notifier)
              //               .state = (v == 0) ? null : v,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),

              // const SizedBox(height: 12),

              // Location switch (كما كان)
              StatefulBuilder(
                builder: (context, setState) => Row(
                  children: [
                    SizedBox(
                        width: 300,
                        child: Text('فلترة حسب الأرخص',
                            style: Theme.of(context).textTheme.titleMedium)),
                    Expanded(
                      child: Switch(
                        value: cheapest,
                        activeColor: Colors.teal.shade700,
                        onChanged: (v) {
                          // ref.read(selectedLocationProvider.notifier).state = v;
                          cheapest = !cheapest;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
              StatefulBuilder(
                builder: (context, setState) => Row(
                  children: [
                    SizedBox(
                        width: 300,
                        child: Text('فلترة حسب التقييم',
                            style: Theme.of(context).textTheme.titleMedium)),
                    Expanded(
                      child: Switch(
                        value: rating,
                        activeColor: Colors.teal.shade700,
                        onChanged: (v) {
                          // ref.read(selectedLocationProvider.notifier).state = v;
                          rating = !rating;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
              StatefulBuilder(
                builder: (context, setState) => Row(
                  children: [
                    SizedBox(
                        width: 300,
                        child: Text('إظهار فقط الاماكن التي تحوي حسومات',
                            style: Theme.of(context).textTheme.titleMedium)),
                    Expanded(
                      child: Switch(
                        value: offers,
                        activeColor: Colors.teal.shade700,
                        onChanged: (v) {
                          // ref.read(selectedLocationProvider.notifier).state = v;
                          offers = !offers;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),

              StatefulBuilder(
                builder: (context, setState) => Row(
                  children: [
                    SizedBox(
                        width: 300,
                        child: Text('الأقرب الي',
                            style: Theme.of(context).textTheme.titleMedium)),
                    Expanded(
                      child: Switch(
                        value: location,
                        activeColor: Colors.teal.shade700,
                        onChanged: (v) {
                          // ref.read(selectedLocationProvider.notifier).state = v;
                          location = !location;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Activities chips (اختاري نوع النشاط لفلترة الأماكن)
              // if (activityList.isNotEmpty) ...[
              //   Align(
              //       alignment: Alignment.centerRight,
              //       child: Text('الأنشطة',
              //           style: Theme.of(context).textTheme.titleMedium)),
              //   const SizedBox(height: 8),
              //   Wrap(
              //     spacing: 8,
              //     runSpacing: 8,
              //     children: [
              //       ChoiceChip(
              //         label: const Text('الكل'),
              //         selected: selectedActivity == null,
              //         selectedColor: Colors.teal.shade700,
              //         backgroundColor: Colors.teal.shade200,
              //         labelStyle: TextStyle(
              //             color: selectedActivity == null
              //                 ? Colors.white
              //                 : Colors.teal.shade900),
              //         onSelected: (_) => ref
              //             .read(selectedActivityProvider.notifier)
              //             .state = null,
              //       ),
              //       ...activityList.map((act) {
              //         final selected = act == selectedActivity;
              //         return ChoiceChip(
              //           label: Text(act),
              //           selected: selected,
              //           selectedColor: Colors.teal.shade700,
              //           backgroundColor: Colors.teal.shade200,
              //           labelStyle: TextStyle(
              //               color:
              //                   selected ? Colors.white : Colors.teal.shade900),
              //           onSelected: (_) => ref
              //               .read(selectedActivityProvider.notifier)
              //               .state = selected ? null : act,
              //         );
              //       }),
              //     ],
              //   ),
              //   const SizedBox(height: 12),
              // ],

              StatefulBuilder(
                builder: (context, setState) => SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.teal.shade700,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () async {
                      String? longitude;
                      String? latitude;
                      LocationData? currentLocation;
                      if (location) {
                        isLoading = true;
                        setState(() {});
                        currentLocation = await getLocation();
                        if (currentLocation != null) {
                          longitude = currentLocation.longitude.toString();
                          latitude = currentLocation.latitude.toString();
                        }
                        isLoading = false;
                        setState(() {});
                      }
                      await onFilter(cheapest, rating, offers, location,
                          longitude, latitude);
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ))
                        : const Text('تطبيق',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () async {
                        // إعادة التعيين
                        // ref.read(selectedRatingProvider.notifier).state = null;
                        // ref.read(selectedBudgetProvider.notifier).state = null;
                        // ref.read(selectedLocationProvider.notifier).state =
                        //     null;
                        // ref.read(selectedActivityProvider.notifier).state =
                        //     null;

                        onFilter(false, false, false, false, null, null);
                        Navigator.pop(context);
                      },
                      child: const Text('مسح الفلاتر'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
