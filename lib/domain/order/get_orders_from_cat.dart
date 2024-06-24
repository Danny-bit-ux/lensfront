import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../../model/order_model.dart';

class GetOrdersFromCategory extends ChangeNotifier {
  Dio dio = Dio();
  List<OrderModel> orders = [];

  void clearList() {
    orders.clear();
    notifyListeners();
  }
}