// lib/features/home/providers/home_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../places/data/model/place_model.dart';
import '../pages/home_page.dart';

// Static provider (البيانات الثابتة عندك أو لاحقاً جايه من API)
final placesProvider = Provider<List<PlaceModel>>((ref) {
  // حافظت على مكان تعريفك الأصلي للـ sample data
  // افترضت أنه عندك نفس الـ list كما في HomePage القديم
  // لو جبتيها من API استبدليها بAsyncProvider لاحقاً.
  return ref.read(homePlacesStaticProvider);
});

// هذا provider افتراضي يعيد نفس البيانات لو ما تيجي من API
final homePlacesStaticProvider = Provider<List<PlaceModel>>((ref) {
  // إذا عندك ملف ثابت تعيديه هنا، أو انسخي بياناتك هنا مؤقتاً.
  return [];
});

/// فلتر/فرز مركب: يعتمد على كل حالات الفلاتر المتاحة
final filteredPlacesProvider = Provider<List<PlaceModel>>((ref) {
  final all = ref.watch(placesProvider);
  final selectedProvince = ref.watch(selectedProvinceProvider);
  final query = ref.watch(searchQueryProvider).trim();
  final minRating = ref.watch(selectedRatingProvider);
  final maxBudget = ref.watch(selectedBudgetProvider); // المستخدم يختار قيمة للميزانية => نعرض الأماكن أقل أو يساوي
  final selectedActivity = ref.watch(selectedActivityProvider);

  // فلترة مبدئية
  var list = all.where((p) {
    // فلترة بالمحافظة: نتحقق إن حقل location يحتوي اسم المحافظة (أكثر مرونة)
    final matchesProvince = selectedProvince == null
        ? true
        : (p.location?.toLowerCase().contains(selectedProvince.toLowerCase()) ?? false)
        || (p.province != null && p.province!.toLowerCase() == selectedProvince.toLowerCase());

    // فلترة البحث: بالاسم أو الوصف
    final matchesQuery = query.isEmpty
        ? true
        : (p.name?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
        (p.description?.toLowerCase().contains(query.toLowerCase()) ?? false);

    // فلترة النشاط (إذا اختار المستخدم نشاط)
    final matchesActivity = selectedActivity == null
        ? true
        : (p.activities?.any((a) {
      final name = (a['name'] ?? '').toString().toLowerCase();
      return name.contains(selectedActivity.toLowerCase());
    }) ??
        false);

    // فلترة التقييم: اذا المكان فيه خاصية rating واذا المستخدم حدد حد أدنى
    final matchesRating = minRating == null
        ? true
        : ((p.rating != null) ? (p.rating! >= minRating) : false);

    // فلترة الميزانية: هنا نحسب أقل تكلفة لنشاط داخل المكان (إذا وجدت)
    final placeMinCost = _minCostOfPlace(p);
    final matchesBudget = maxBudget == null ? true : (placeMinCost != null ? placeMinCost <= maxBudget : false);

    return matchesProvince && matchesQuery && matchesActivity && matchesRating && matchesBudget;
  }).toList();

  // الآن نطبّق الفرز:
  // 1) إذا حدد المستخدم قيمة لميزانية (selectedBudgetProvider) ففرز حسب تكلفة المكان من الأقل للأعلى
  if (maxBudget != null) {
    list.sort((a, b) {
      final aCost = _minCostOfPlace(a) ?? double.infinity;
      final bCost = _minCostOfPlace(b) ?? double.infinity;
      return aCost.compareTo(bCost);
    });
    return list;
  }

  // 2) إذا حدّد المستخدم التصفية حسب التقييم (selectedRatingProvider !== null) نرتّب من الأعلى إلى الأدنى
  if (minRating != null) {
    // لو بعض الأماكن ما عندها rating فنجعلها في الأسفل
    list.sort((a, b) {
      final ar = a.rating ?? -1.0;
      final br = b.rating ?? -1.0;
      return br.compareTo(ar);
    });
    return list;
  }

  // 3) إذا المستخدم اختار فرز صريح (مثلاً يمكننا أن نضيف provider لفرز صريح لاحقاً)
  // حالياً لو ما حدد شيء نرجّع كما هو (ترتيب المصدر)
  return list;
});

double? _minCostOfPlace(PlaceModel p) {
  try {
    if (p.activities == null || p.activities!.isEmpty) return null;
    final costs = p.activities!
        .map((a) {
      final c = a['cost'];
      if (c == null) return null;
      if (c is num) return c.toDouble();
      final parsed = double.tryParse(c.toString());
      return parsed;
    })
        .whereType<double>()
        .toList();
    if (costs.isEmpty) return null;
    return costs.reduce((v, e) => v < e ? v : e);
  } catch (e) {
    return null;
  }
}

// الاحتفاظ ببعض providers اللي عندك:
final selectedProvinceProvider = StateProvider<String?>((ref) => null);
final searchQueryProvider = StateProvider<String>((ref) => '');
final selectedRatingProvider = StateProvider<double?>((ref) => null);
final selectedBudgetProvider = StateProvider<double?>((ref) => null);
final selectedLocationProvider = StateProvider<bool?>((ref) => null);

// NEW: نشاط مختار
final selectedActivityProvider = StateProvider<String?>((ref) => null);
