import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../ServerRoutes.dart';
import 'user/auth/create_user.dart';

class GetCitysList extends ChangeNotifier {
  var allCityList = [];
  List popularCityList= [];
  var selectedCity = 'Не выбран';
  Dio dio = Dio();
  Future<void> getAllCitys() async {
    if(allCityList.length < 2) {
      final response = await dio.get(
          '${ServerRoutes.host}/getallcitylist');
      final json = jsonDecode(response.data);
      allCityList = json['citys'];
      notifyListeners();
    }
  }
  Future<void> getPopularCitys() async {
    if(popularCityList.length < 2) {
      final response = await dio.get(
          '${ServerRoutes.host}/popularallcitylist');
      final json = jsonDecode(response.data);
        popularCityList = json;

      notifyListeners();
    }
  }
  void selectCity(String city) {
    selectedCity = city;
    notifyListeners();
  }
  Future<void> updateCity(city) async {
    await dio.post('${ServerRoutes.host}/changeCity',
    data: {
      'uid': uid,
      'city': city,
    });
  }
}

class City {
  final name;
  final id;
  const City({required this.name, required this.id});
}