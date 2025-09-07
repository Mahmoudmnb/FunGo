import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

import '../../../core/constants.dart';

Future<List?> getFavorites({required BuildContext context}) async {
  List? data;
  await checkInternet(() async {
    ToastContext().init(context);
    http.Response res = await http.get(
      Uri.parse(Constants.indexFavorite),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Constants.user!.token}',
      },
    );
    if (res.statusCode == 200) {
      data = jsonDecode(res.body)['data'];
    } else {
      Toast.show('حصل خطأ غير متوقع حاول ثانية', duration: Toast.lengthLong);
    }
  }, context);
  return data;
}
