import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../ServerRoutes.dart';

class GetCategoriesList extends ChangeNotifier {
  List categories = [];
  List podcategory = [];
  Dio dio = Dio();
  Future<void> getCategoriesList() async {
    if (categories.length < 2) {
      final response = await dio.get(
          '${ServerRoutes.host}/getsphereslist');
      final json = jsonDecode(response.data);
      categories = json['spheres'];
      notifyListeners();
    }
  }
}

