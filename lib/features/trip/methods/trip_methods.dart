import 'package:flutter/material.dart';
import 'package:fun_go_app/core/constants.dart';
import 'package:http/http.dart' as http;

Future<bool> addTrip(
    {required int placeId, required BuildContext context}) async {
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

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }, context);
  return isSuccess;
}
