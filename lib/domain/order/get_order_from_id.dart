import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../ServerRoutes.dart';

class GetOrderFromId extends ChangeNotifier {
  Dio dio = Dio();
  var order;
  Future<void> getOrderFromId(int ind) async {
    final response = await dio.post('${ServerRoutes.host}/getorderfid',
    data: {'index': ind});
    print(response.data);
    order = jsonDecode(response.data);
    print(order);
    notifyListeners();
    notifyListeners();
}
 // final response = awaait dio.get('${ServerRoutes.host}');
}