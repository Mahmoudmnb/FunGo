import '../../domain/entities/trip.dart';
import '../../presentation/place.dart';

class TripService {
  static final TripService _instance = TripService._internal();
  factory TripService() => _instance;
  TripService._internal();

  final List<Trip> _trips = [];
  final List<Place> _availablePlaces = [
    const Place(
      id: 1,
      name: 'قلعة حلب',
      description: 'إحدى أقدم وأكبر القلاع في العالم، تقع وسط مدينة حلب',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/5/58/Aleppo_Citadel_01.jpg',
      location: 'حلب، سوريا',
    ),
    const Place(
      id: 2,
      name: 'الجامع الأموي',
      description: 'من أهم المساجد التاريخية في العالم الإسلامي',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/9/92/Umayyad_Mosque_Damascus.jpg',
      location: 'دمشق، سوريا',
    ),
    const Place(
      id: 3,
      name: 'معلولا',
      description: 'قرية جبلية مشهورة ببيوتها الملونة واللغة الآرامية',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/6/6a/Maaloula.jpg',
      location: 'ريف دمشق، سوريا',
    ),
    const Place(
      id: 4,
      name: 'تدمر',
      description: 'مدينة أثرية تعود للحضارات القديمة وتشتهر بالأعمدة والمعابد',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/f/f7/Palmyra_%28Roman_city%29.jpg',
      location: 'حمص، سوريا',
    ),
    const Place(
      id: 5,
      name: 'اللاذقية - الكورنيش البحري',
      description: 'شاطئ جميل ومكان مميز للنزهة على البحر المتوسط',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/2/29/Lattakia_coast.jpg',
      location: 'اللاذقية، سوريا',
    ),
    const Place(
      id: 6,
      name: 'قلعة صلاح الدين',
      description: 'قلعة تاريخية محصنة تقع قرب اللاذقية',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/2/28/Saladin_castle.jpg',
      location: 'اللاذقية، سوريا',
    ),
    const Place(
      id: 7,
      name: 'نواعير حماة',
      description: 'نواعير مائية تاريخية على نهر العاصي',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/1/1f/Norias_Hama.jpg',
      location: 'حماة، سوريا',
    ),
  ];

  List<Place> get availablePlaces => List.unmodifiable(_availablePlaces);

  List<Trip> get trips => List.unmodifiable(_trips);

  void addTrip(Trip trip) {
    _trips.add(trip);
  }

  void removeTrip(String tripId) {
    _trips.removeWhere((trip) => trip.id == tripId);
  }

  void updateTrip(Trip trip) {
    final index = _trips.indexWhere((t) => t.id == trip.id);
    if (index != -1) {
      _trips[index] = trip;
    }
  }

  Place? getPlaceById(int id) {
    try {
      return _availablePlaces.firstWhere((place) => place.id == id);
    } catch (e) {
      return null;
    }
  }
}
