import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/home_providers.dart';
import 'filter_sheet.dart';

class FilterSearchBar extends ConsumerWidget {
  const FilterSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(searchQueryProvider);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
        child: Row(
          children: [
            // زر الفلترة (أيقونة فقط)
            FilterIconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  builder: (_) => const FilterBottomSheet(),
                );
              },
            ),
            const SizedBox(width: 12),
            // حقل البحث الخلاب
            Expanded(
              child: TextField(
                textDirection: TextDirection.rtl,
                textInputAction: TextInputAction.search,
                onChanged:
                    (v) => ref.read(searchQueryProvider.notifier).state = v,
                decoration: InputDecoration(
                  hintText: 'ابحث عن مكان…',
                  filled: true,
                  fillColor: Colors.teal.shade50,
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon:
                      (query.isNotEmpty)
                          ? IconButton(
                            onPressed:
                                () =>
                                    ref
                                        .read(searchQueryProvider.notifier)
                                        .state = '',
                            icon: const Icon(Icons.close_rounded),
                          )
                          : null,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 14,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.teal.shade200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Colors.teal.shade700,
                      width: 1.6,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
