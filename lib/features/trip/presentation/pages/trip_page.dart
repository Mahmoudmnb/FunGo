import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/services/trip_service.dart';
import '../../presentation/place.dart';

class TripPage extends StatefulWidget {
  const TripPage({super.key});

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  final List<Place> _selectedPlaces = [];
  final TripService _tripService = TripService();

  // Map center coordinates (Dubai)
// Map center coordinates (Damascus, Syria)
  static const LatLng _center = LatLng(33.5138, 36.2765);

  @override
  void initState() {
    super.initState();
    // _initializeTrip();
  }

  void _initializeTrip() {
    // Add some initial places for demonstration
    _addPlaceToTrip(_tripService.availablePlaces[0]);
    _addPlaceToTrip(_tripService.availablePlaces[1]);
  }

  void _addPlaceToTrip(Place place) {
    if (!_selectedPlaces.any((p) => p.id == place.id)) {
      setState(() {
        _selectedPlaces.add(place);
        _addMarker(place);
      });
    }
  }

  void _removePlaceFromTrip(Place place) {
    setState(() {
      _selectedPlaces.removeWhere((p) => p.id == place.id);
      _removeMarker(place);
    });
  }

  void _addMarker(Place place) {
    // Generate coordinates around Dubai center for demonstration
    final random = place.id * 0.01;
    final latLng = LatLng(
      _center.latitude + random,
      _center.longitude + random,
    );

    final marker = Marker(
      markerId: MarkerId(place.id.toString()),
      position: latLng,
      infoWindow: InfoWindow(
        title: place.name,
        snippet: place.location,
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    );

    _markers.add(marker);
  }

  void _removeMarker(Place place) {
    _markers
        .removeWhere((marker) => marker.markerId.value == place.id.toString());
  }

  void _showAddPlaceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'إضافة مكان إلى الرحلة',
            style: TextStyle(
              color: Colors.teal.shade800,
              fontWeight: FontWeight.bold,
              fontSize: 16, // Reduced from default
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _tripService.availablePlaces.length,
              itemBuilder: (context, index) {
                final place = _tripService.availablePlaces[index];
                final isSelected = _selectedPlaces.any((p) => p.id == place.id);

                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      place.imageUrl,
                      width: 45, // Reduced from 50
                      height: 45, // Reduced from 50
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 45,
                        height: 45,
                        color: Colors.grey.shade300,
                        child: Icon(Icons.place,
                            color: Colors.grey.shade600,
                            size: 20), // Reduced icon size
                      ),
                    ),
                  ),
                  title: Text(
                    place.name,
                    style:
                        const TextStyle(fontSize: 14), // Reduced from default
                  ),
                  subtitle: Text(
                    place.location,
                    style:
                        const TextStyle(fontSize: 12), // Reduced from default
                  ),
                  trailing: Icon(
                    isSelected ? Icons.check_circle : Icons.add_circle_outline,
                    color: isSelected ? Colors.teal : Colors.grey,
                    size: 20, // Reduced icon size
                  ),
                  onTap: () {
                    if (isSelected) {
                      _removePlaceFromTrip(place);
                    } else {
                      _addPlaceToTrip(place);
                    }
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'إغلاق',
                style: TextStyle(
                  color: Colors.teal.shade700,
                  fontSize: 14, // Reduced from default
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showTripCompletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(Icons.celebration,
                  color: Colors.amber.shade600, size: 24), // Reduced from 28
              const SizedBox(width: 8),
              Text(
                'تهانينا! 🎉',
                style: TextStyle(
                  color: Colors.teal.shade800,
                  fontWeight: FontWeight.bold,
                  fontSize: 18, // Reduced from 20
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on,
                        color: Colors.teal.shade600,
                        size: 18), // Reduced from default
                    const SizedBox(width: 8),
                    Text(
                      'لقد زرت ${_selectedPlaces.length} أماكن في رحلتك!',
                      style: TextStyle(
                        fontSize: 14, // Reduced from 16
                        color: Colors.teal.shade800,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'أحسنت! استمر في استكشاف العالم',
                style: TextStyle(
                  fontSize: 12, // Reduced from 14
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade600,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'رائع!',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold), // Reduced from 16
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'رحلتي',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18), // Reduced from default
        ),
        backgroundColor: Colors.teal.shade700,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, size: 20), // Reduced icon size
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'اضغط على "إضافة مكان" لإضافة أماكن جديدة إلى رحلتك',
                    style: TextStyle(fontSize: 12), // Reduced from default
                  ),
                  duration: Duration(seconds: 3),
                ),
              );
            },
            tooltip: 'معلومات',
          ),
        ],
      ),
      body: Column(
        children: [
          // Real Google Maps Card
          // Container(
          //   margin: const EdgeInsets.all(16),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(20),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.black.withOpacity(0.1),
          //         blurRadius: 10,
          //         offset: const Offset(0, 5),
          //       ),
          //     ],
          //   ),
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(20),
          //     child: Container(
          //       height: 300,
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(20),
          //       ),
          //       child: Stack(
          //         children: [
          //           GoogleMap(
          //             onMapCreated: (GoogleMapController controller) {
          //               _mapController = controller;
          //             },
          //             initialCameraPosition: const CameraPosition(
          //               target: _center,
          //               zoom: 11.0,
          //             ),
          //             markers: _markers,
          //             myLocationEnabled: true,
          //             myLocationButtonEnabled: true,
          //             zoomControlsEnabled: false,
          //             mapToolbarEnabled: false,
          //             mapType: MapType.normal,
          //           ),
          //           // Trip info overlay
          //           if (_selectedPlaces.isNotEmpty)
          //             Positioned(
          //               top: 16,
          //               left: 16,
          //               child: Container(
          //                 padding: const EdgeInsets.symmetric(
          //                     horizontal: 10, vertical: 6), // Reduced padding
          //                 decoration: BoxDecoration(
          //                   color: Colors.white.withOpacity(0.9),
          //                   borderRadius:
          //                       BorderRadius.circular(16), // Reduced from 20
          //                   boxShadow: [
          //                     BoxShadow(
          //                       color: Colors.black.withOpacity(0.1),
          //                       blurRadius: 4,
          //                       offset: const Offset(0, 2),
          //                     ),
          //                   ],
          //                 ),
          //                 child: Row(
          //                   mainAxisSize: MainAxisSize.min,
          //                   children: [
          //                     Icon(
          //                       Icons.location_on,
          //                       color: Colors.teal.shade600,
          //                       size: 16, // Reduced from 20
          //                     ),
          //                     const SizedBox(width: 4),
          //                     Text(
          //                       '${_selectedPlaces.length} أماكن',
          //                       style: TextStyle(
          //                         color: Colors.teal.shade800,
          //                         fontWeight: FontWeight.bold,
          //                         fontSize: 12, // Reduced from 14
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),

          // Selected Locations Section
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'الأماكن المختارة',
                        style: TextStyle(
                          fontSize: 16, // Reduced from 20
                          fontWeight: FontWeight.bold,
                          color: Colors.teal.shade800,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: _showAddPlaceDialog,
                        icon: const Icon(Icons.add_location,
                            size: 18), // Reduced icon size
                        label: const Text(
                          'إضافة مكان',
                          style:
                              TextStyle(fontSize: 12), // Reduced from default
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal.shade600,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // Reduced from 25
                          ),
                          elevation: 3,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8), // Reduced padding
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12), // Reduced from 16

                  if (_selectedPlaces.isEmpty)
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.all(16), // Reduced from 20
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.map_outlined,
                                size: 50, // Reduced from 60
                                color: Colors.grey.shade400,
                              ),
                            ),
                            const SizedBox(height: 16), // Reduced from 20
                            Text(
                              'لا توجد أماكن مختارة',
                              style: TextStyle(
                                fontSize: 16, // Reduced from 18
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6), // Reduced from 8
                            Text(
                              'اضغط على "إضافة مكان" لبدء رحلتك',
                              style: TextStyle(
                                fontSize: 12, // Reduced from 14
                                color: Colors.grey.shade500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.builder(
                        itemCount: _selectedPlaces.length,
                        itemBuilder: (context, index) {
                          final place = _selectedPlaces[index];
                          return Container(
                            margin: const EdgeInsets.only(
                                bottom: 10), // Reduced from 12
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(14), // Reduced from 16
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding:
                                  const EdgeInsets.all(12), // Reduced from 16
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    10), // Reduced from 12
                                child: Image.network(
                                  place.imageUrl,
                                  width: 60, // Reduced from 70
                                  height: 60, // Reduced from 70
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    width: 60,
                                    height: 60,
                                    color: Colors.grey.shade300,
                                    child: Icon(
                                      Icons.place,
                                      color: Colors.grey.shade600,
                                      size: 25, // Reduced from 30
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                place.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14, // Reduced from 16
                                ),
                              ),
                              subtitle: Text(
                                place.location,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12, // Reduced from 14
                                ),
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: Colors.red.shade400,
                                  size: 20, // Reduced icon size
                                ),
                                onPressed: () => _removePlaceFromTrip(place),
                                tooltip: 'حذف من الرحلة',
                                padding:
                                    const EdgeInsets.all(4), // Reduced padding
                                constraints: const BoxConstraints(
                                  minWidth: 32,
                                  minHeight: 32,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Bottom Button
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed:
                  _selectedPlaces.isNotEmpty ? _showTripCompletionDialog : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade600,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 14), // Reduced from 16
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22), // Reduced from 25
                ),
                elevation: 5,
                shadowColor: Colors.teal.withOpacity(0.3),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 20, // Reduced from 24
                  ),
                  SizedBox(width: 6), // Reduced from 8
                  Text(
                    'جميع الأماكن تمت زيارتها',
                    style: TextStyle(
                      fontSize: 16, // Reduced from 18
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
