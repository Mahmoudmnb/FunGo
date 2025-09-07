import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

import '../../../core/constants.dart';
import '../../places/models/place_cart_model.dart';
import '../../places/models/place_model.dart';

Future<List<PlaceCartModel>?> getPlacesWithFilter({
  required BuildContext context,
  required String cityFilter,
}) async {
  List<PlaceCartModel>? data;
  await checkInternet(() async {
    ToastContext().init(context);
    http.Response res = await http.get(
      Uri.parse('${Constants.filterPlaces}?governorate=$cityFilter'),
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

// ?filters[]=cheapest&filters[]=offers&filters[]=rating&filters[]=nearest&activity_type_id=1&governorate=aleppo

Future<PlaceModel?> getPlace({
  required BuildContext context,
  required int id,
}) async {
  PlaceModel? data;
  await checkInternet(() async {
    ToastContext().init(context);
    http.Response res = await http.get(
      Uri.parse('${Constants.showPlace}/$id/show'),
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
      final decoded = jsonDecode(res.body)['data'];
      data = PlaceModel.fromJson(decoded);
      List favData = jsonDecode(favRes.body)['data'];
      for (var element in favData) {
        if (element['id'] == data!.id!) {
          data!.isFavorite = true;
          break;
        }
      }
    } else {
      Toast.show('حصل خطأ غير متوقع حاول ثانية', duration: Toast.lengthLong);
    }
  }, context);
  return data;
}

Future<PlaceModel?> addOrDeletePlaceFromFavorite(
    {required BuildContext context,
    required int id,
    required bool isFavorite}) async {
  PlaceModel? data;
  await checkInternet(() async {
    ToastContext().init(context);
    if (isFavorite) {
      http.Response res = await http.post(
        Uri.parse('${Constants.addPlaceToFavorite}/$id/store'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Constants.user!.token}',
        },
      );
      if (res.statusCode == 200) {
      } else {
        Toast.show('حصل خطأ غير متوقع حاول ثانية', duration: Toast.lengthLong);
      }
    } else {
      http.Response res = await http.delete(
        Uri.parse('${Constants.deletePlaceFromFavorite}/$id/delete'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Constants.user!.token}',
        },
      );
      if (res.statusCode == 200) {
      } else {
        Toast.show('حصل خطأ غير متوقع حاول ثانية', duration: Toast.lengthLong);
      }
    }
  }, context);
  return data;
}

Future<PlaceModel?> ratePlaces(
    {required BuildContext context,
    required int id,
    required double rating}) async {
  PlaceModel? data;
  await checkInternet(() async {
    ToastContext().init(context);

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${Constants.user!.token}',
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://fungo.mustafafares.com/api/review/store'));
    request.fields.addAll({'rating': '2', 'place_id': '22'});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      log(await response.stream.bytesToString());
    } else {
      log(response.reasonPhrase.toString());
    }
  }, context);
  return data;
}

Future<Stories?> uploadStory(
    String text, XFile file, int placeId, BuildContext context) async {
  Stories? stories;
  await checkInternet(() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${Constants.user!.token}'
    };
    var request = http.MultipartRequest('POST', Uri.parse(Constants.addStory));
    request.fields.addAll({'txt': text, 'place_id': placeId.toString()});
    request.files.add(await http.MultipartFile.fromPath('image', file.path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      Map body = jsonDecode(await response.stream.bytesToString());
      stories = Stories(
        createdAt: body['data']['createdAt'],
        image: [body['data']['image']],
        txt: body['data']['txt'],
        storyId: body['data']['id'],
        userName: body['data']['userName'],
      );
    } else {
      log(response.reasonPhrase.toString());
    }
  }, context);
  return stories;
}
