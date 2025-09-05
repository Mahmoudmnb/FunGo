# Trip Feature

## Overview
The Trip feature allows users to create and manage their trips by adding/removing places and tracking their progress.

## Features
- **Map Card**: A beautiful map container with place markers (currently a placeholder)
- **Place Management**: Add and remove places from your trip
- **Visual Feedback**: See selected places with images and names
- **Trip Completion**: Track when all places have been visited
- **Beautiful UI**: Consistent with the app's teal theme

## Current Implementation
- Uses local state management (no external state management)
- Placeholder map card with visual markers
- Virtual locations for demonstration
- Responsive design with Arabic text support

## Google Maps Integration (Future)
To integrate real Google Maps functionality:

1. **Android Setup**:
   - Add Google Maps API key to `android/app/src/main/AndroidManifest.xml`
   - Enable Maps SDK in Google Cloud Console

2. **iOS Setup**:
   - Add Google Maps API key to `ios/Runner/AppDelegate.swift`
   - Enable Maps SDK in Google Cloud Console

3. **Replace Placeholder**:
   - Replace the placeholder map container with `GoogleMap` widget
   - Add real coordinates for places
   - Implement marker management

## Files Structure
```
lib/features/trip/
├── domain/
│   └── entities/
│       └── trip.dart          # Trip entity
├── data/
│   └── services/
│       └── trip_service.dart  # Trip data service
└── presentation/
    └── pages/
        └── trip_page.dart     # Main trip page UI
```

## Usage
1. Navigate to the Trip tab (4th tab in bottom navigation)
2. Click "إضافة مكان" to add places to your trip
3. View selected places in the list below the map
4. Remove places using the delete button
5. Click "جميع الأماكن تمت زيارتها" when trip is complete

## Customization
- Modify `_availablePlaces` in `trip_service.dart` to add more locations
- Update map center coordinates for different regions
- Customize the UI theme colors and styles
- Add more trip management features as needed
