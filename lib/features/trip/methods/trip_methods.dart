import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

import '../../../core/constants.dart';
import '../models/trip_model.dart';

Future<bool> addTrip(
    {required int placeId, required BuildContext context}) async {
  ToastContext().init(context);
  bool isSuccess = false;
  await checkInternet(() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${Constants.user!.token}'
    };
    var request = http.MultipartRequest('POST', Uri.parse(Constants.addTrip));
    request.fields.addAll({'place_id': placeId.toString()});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      log(await response.stream.bytesToString());
    } else {
      Toast.show('خطأ غير معروف حاول ثانية', duration: Toast.lengthLong);
      log(response.reasonPhrase.toString());
    }
  }, context);
  return isSuccess;
}

Future<List<TripModel>?> getTrips({required BuildContext context}) async {
  ToastContext().init(context);
  List<TripModel>? data;
  await checkInternet(() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${Constants.user!.token}'
    };
    var request = http.MultipartRequest('POST', Uri.parse(Constants.getMyTrip));
    request.fields.addAll({'longitude': '31.52651', 'latitude': '30.4562'});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      List body =
          jsonDecode(await response.stream.bytesToString())['data'] as List;
      data = body.map((e) => TripModel.fromJson(e)).toList();
    } else {
      Toast.show('خطأ غير معروف حاول ثانية', duration: Toast.lengthLong);
      print(response.reasonPhrase);
    }
  }, context);
  return data;
}

Future<bool> deleteTrip(
    {required int tripId, required BuildContext context}) async {
  ToastContext().init(context);
  bool isSuccess = false;
  await checkInternet(() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${Constants.user!.token}'
    };
    var request = http.MultipartRequest(
        'DELETE', Uri.parse('${Constants.deletePlace}/$tripId/place'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      isSuccess = true;
      log(await response.stream.bytesToString());
    } else {
      Toast.show('خطأ غير معروف حاول ثانية', duration: Toast.lengthLong);
      log(response.reasonPhrase.toString());
    }
  }, context);
  return isSuccess;
}
