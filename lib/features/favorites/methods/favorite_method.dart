import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

import '../../../core/constants.dart';
import '../../places/models/place_cart_model.dart';
import '../../places/models/sales_places_model.dart';

Future<List<PlaceCartModel>?> getFavorites(
    {required BuildContext context}) async {
  List<PlaceCartModel>? data;
  await checkInternet(() async {
    ToastContext().init(context);
    http.Response res = await http.get(
      Uri.parse(Constants.indexFavorite),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Constants.user!.token}',
      },
    );
    http.Response favRes = await http.get(
      Uri.parse(Constants.indexFavorite),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Constants.user!.token}',
      },
    );
    if (res.statusCode == 200 && favRes.statusCode == 200) {
      final decoded = jsonDecode(res.body)['data'] as List;
      List favData = jsonDecode(favRes.body)['data'];

      data = decoded.map((e) {
        bool isFavorite = false;
        for (var element in favData) {
          if (element['id'] == e['id']) {
            isFavorite = true;
            break;
          }
        }
        PlaceCartModel place = PlaceCartModel.fromJson(e);
        place.isFavorite = isFavorite;
        return place;
      }).toList();
    } else {
      Toast.show('حصل خطأ غير متوقع حاول ثانية', duration: Toast.lengthLong);
    }
  }, context);
  return data;
}

Future<List<SalesPlacesModel>?> getSales(
    {required BuildContext context, int? placeId}) async {
  List<SalesPlacesModel>? data;
  http.Response res;
  await checkInternet(() async {
    ToastContext().init(context);
    if (placeId != null) {
      res = await http.get(
        Uri.parse('${Constants.getSalesPlace}/$placeId/getSalesPlace'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Constants.user!.token}',
        },
      );
    } else {
      res = await http.get(
        Uri.parse('${Constants.getSalesPlace}/index'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Constants.user!.token}',
        },
      );
    }
    if (res.statusCode == 200) {
      final decoded = jsonDecode(res.body)['data'] as List?;
      if (decoded != null) {
        data = decoded.map((e) => SalesPlacesModel.fromJson(e)).toList();
      } else {
        data = [];
      }
    } else {
      Toast.show('حصل خطأ غير متوقع حاول ثانية', duration: Toast.lengthLong);
    }
  }, context);
  return data;
}
