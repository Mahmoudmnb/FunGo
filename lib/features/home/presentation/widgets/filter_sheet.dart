// lib/features/home/widgets/filter_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/home_providers.dart';
import '../../../places/data/model/place_model.dart';

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

class FilterBottomSheet extends ConsumerWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rating = ref.watch(selectedRatingProvider);
    final budget = ref.watch(selectedBudgetProvider);
    final location = ref.watch(selectedLocationProvider);
    final selectedActivity = ref.watch(selectedActivityProvider);
    final all = ref.watch(placesProvider);

    // جمع أسماء الانشطة المتاحة لاستخدامها في chips
    final activities = <String>{};
    for (final p in all) {
      if (p.activities != null) {
        for (final a in p.activities!) {
          final name = (a['name'] ?? '').toString().trim();
          if (name.isNotEmpty) activities.add(name);
        }
      }
    }
    final activityList = activities.toList();

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 16),

              // Rating slider without the "bubble" value indicator
              Row(
                children: [
                  SizedBox(width: 80, child: Text('التقييم (الأدنى)', style: Theme.of(context).textTheme.titleMedium)),
                  Expanded(
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        showValueIndicator: ShowValueIndicator.never,
                        trackHeight: 4,
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 9),
                      ),
                      child: Slider(
                        value: (rating ?? 0),
                        min: 0,
                        max: 5,
                        divisions: 5,
                        label: '', // نخليها فارغة حتى لا تظهر
                        activeColor: Colors.teal.shade700,
                        onChanged: (v) => ref.read(selectedRatingProvider.notifier).state = (v == 0) ? null : v,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Budget slider: يعرض الحد الأقصى للميزانية، والفرز حسب الميزانية سيتم تطبيقه في provider
              Row(
                children: [
                  SizedBox(width: 80, child: Text('ميزانيتي (أقصى)', style: Theme.of(context).textTheme.titleMedium)),
                  Expanded(
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        showValueIndicator: ShowValueIndicator.never,
                        trackHeight: 4,
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 9),
                      ),
                      child: Slider(
                        value: (budget ?? 0),
                        min: 0,
                        max: 500,
                        divisions: 20,
                        label: '',
                        activeColor: Colors.teal.shade700,
                        onChanged: (v) => ref.read(selectedBudgetProvider.notifier).state = (v == 0) ? null : v,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Location switch (كما كان)
              Row(
                children: [
                  SizedBox(width: 80, child: Text('موقعي', style: Theme.of(context).textTheme.titleMedium)),
                  Expanded(
                    child: Switch(
                      value: location ?? false,
                      activeColor: Colors.teal.shade700,
                      onChanged: (v) => ref.read(selectedLocationProvider.notifier).state = v,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Activities chips (اختاري نوع النشاط لفلترة الأماكن)
              if (activityList.isNotEmpty) ...[
                Align(alignment: Alignment.centerRight, child: Text('الأنشطة', style: Theme.of(context).textTheme.titleMedium)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ChoiceChip(
                      label: const Text('الكل'),
                      selected: selectedActivity == null,
                      selectedColor: Colors.teal.shade700,
                      backgroundColor: Colors.teal.shade200,
                      labelStyle: TextStyle(color: selectedActivity == null ? Colors.white : Colors.teal.shade900),
                      onSelected: (_) => ref.read(selectedActivityProvider.notifier).state = null,
                    ),
                    ...activityList.map((act) {
                      final selected = act == selectedActivity;
                      return ChoiceChip(
                        label: Text(act),
                        selected: selected,
                        selectedColor: Colors.teal.shade700,
                        backgroundColor: Colors.teal.shade200,
                        labelStyle: TextStyle(color: selected ? Colors.white : Colors.teal.shade900),
                        onSelected: (_) => ref.read(selectedActivityProvider.notifier).state = selected ? null : act,
                      );
                    }).toList(),
                  ],
                ),
                const SizedBox(height: 12),
              ],

              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.teal.shade700,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('تطبيق', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // إعادة التعيين
                        ref.read(selectedRatingProvider.notifier).state = null;
                        ref.read(selectedBudgetProvider.notifier).state = null;
                        ref.read(selectedLocationProvider.notifier).state = null;
                        ref.read(selectedActivityProvider.notifier).state = null;
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
