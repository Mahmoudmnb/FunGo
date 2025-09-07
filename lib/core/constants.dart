import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:network_info/network_info.dart';
import 'package:toast/toast.dart';

import '../features/auth/models/user.dart';

class Constants {
  static User? user;

  static const String _domain = 'https://fungo.mustafafares.com';

  //* user end points
  static const register = '$_domain/api/users/register';
  static const login = '$_domain/api/users/login';
  static const logout = '$_domain/api/users/logout';

  //* places end points
  static const showPlace = '$_domain/api/places';
  static const searchPlaces = '$_domain/api/places/index?search=';
  static const filterPlaces = '$_domain/api/places/index';

  //* trip end points
  static const addTrip = '$_domain/api/trips/add-trip';
  static const getMyTrip = '$_domain/api/trips/my-trip';
  static const deletePlace = '$_domain/api/trips/my-trip';
  static const deleteTrip = '$_domain/api/trips/my-trip';

  //* story end points
  static const addStory = '$_domain/api/story/store';
  static const deleteStory = '$_domain/api/story';
  static const getStoryForPlace = '$_domain/api/story';

  //* reviews end points
  static const addReview = '$_domain/api/review/store';
  static const deleteReview = '$_domain/api/review';
  static const updateReview = '$_domain/api/review';

  //* favorite end points
  static const addPlaceToFavorite = '$_domain/api/favorites';
  static const indexFavorite = '$_domain/api/favorites/index';
  static const deletePlaceFromFavorite = '$_domain/api/favorites';

  //* sales end points
  static const getSalesPlace = '$_domain/api/sale';
  static const getAllSales = '$_domain/api/places/22/show';

  //* activityTypes end points
  static const getAllActivityTypes = '$_domain/api/activity-type';
}

Future checkInternet(Future Function() fun, BuildContext? context) async {
  context != null ? ToastContext().init(context) : null;
  bool isMounted = context != null && context.mounted
      ? true
      : context == null
          ? true
          : false;
  try {
    bool isConnected = await NetworkInfo.instance.isConnected;
    if (isMounted) {
      if (isConnected) {
        await fun();
      } else if (context != null) {
        Toast.show('تأكد من اتصالك بالانترنت', duration: Toast.lengthLong);
      }
    }
  } on SocketException catch (_) {
    if (context != null && context.mounted) {
      Toast.show('تأكد من اتصالك بالانترنت', duration: Toast.lengthLong);
    }
  } catch (e) {
    log(e.toString());
    if (isMounted && context != null) {
      Toast.show('خطأ غير معروف حاول ثانية', duration: Toast.lengthLong);
    }
  }
}

String getEnglishCityName(String arabicName) {
  switch (arabicName) {
    case 'دمشق':
      return 'damascus';
    case 'حلب':
      return 'aleppo';
    case 'حمص':
      return 'homs';
    case 'اللاذقية':
      return 'latakia';
    case 'طرطوس':
      return 'tartous';
    case 'بانياس':
      return 'banias';
    case 'إدلب':
      return 'idlib';
    case 'درعا':
      return 'deraa';
    case 'السويداء':
      return 'sweida';
    case 'الرقة':
      return 'raqqa';
    case 'دير الزور':
      return 'deir_ezzor';
    case 'الحسكة':
      return 'hasakah';
    case 'القامشلي':
      return 'qamisli';
    case 'تدمر':
      return 'palmyra';
    case 'الكل':
      return 'palmyra';
    default:
      return 'aaaaaaaa';
  }
}
