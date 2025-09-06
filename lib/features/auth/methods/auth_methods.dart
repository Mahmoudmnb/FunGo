import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../../../core/constants.dart';
import '../models/user.dart';

Future<bool> login(
    {required String email,
    required String password,
    required BuildContext context}) async {
  bool isSuccess = false;
  await checkInternet(() async {
    ToastContext().init(context);
    http.Response res = await http.post(
      Uri.parse(Constants.login),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: {'email': email, 'password': password},
    );

    if (res.statusCode == 201) {
      User user = User.fromMap(jsonDecode(res.body)['data']);
      Constants.user = user;
      SharedPreferences sh = await SharedPreferences.getInstance();
      sh.setString('user', jsonEncode(user.toMap()));
      isSuccess = true;
    } else if (res.statusCode == 401) {
      Toast.show(jsonDecode(res.body)['message'], duration: Toast.lengthLong);
    } else {
      Toast.show('حصل خطأ غير متوقع حاول ثانية', duration: Toast.lengthLong);
    }
  }, context);
  return isSuccess;
}

Future<bool> register(
    {required String email,
    required String password,
    required String name,
    required BuildContext context}) async {
  bool isSuccess = false;
  await checkInternet(() async {
    ToastContext().init(context);
    http.Response res = await http.post(
      Uri.parse(Constants.register),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: {
        'name': name,
        'email': email,
        'password': password,
      },
    );
    if (res.statusCode == 201) {
      User user = User.fromMap(jsonDecode(res.body)['data']);
      Constants.user = user;
      SharedPreferences sh = await SharedPreferences.getInstance();
      sh.setString('user', jsonEncode(user.toMap()));
      isSuccess = true;
    } else if (res.statusCode == 422) {
      Toast.show(jsonDecode(res.body)['message'], duration: Toast.lengthLong);
    } else {
      Toast.show('حصل خطأ غير متوقع حاول ثانية', duration: Toast.lengthLong);
    }
  }, context);
  return isSuccess;
}
