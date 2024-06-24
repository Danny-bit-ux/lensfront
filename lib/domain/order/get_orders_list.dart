import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../ServerRoutes.dart';
import '../../model/order_model.dart';
import '../../model/response_from_order_model.dart';

class GetOrdersList extends ChangeNotifier {
  List<OrderModel> orders = [];
  List<OrderModel> myOrders = [];
  Dio dio = Dio();
  Future<void> getAllOrders() async {
    final response = await dio.get('${ServerRoutes.host}/getorders');
    List json = jsonDecode(response.data);
    orders.clear();
    print(response.data);
    for (int i = 0; i < json.length; i++) {
      var data = json[i];
      orders.add(OrderModel(
          uid: data['uid'],
          lat: data['geo_x'],
          long: data['geo_y'],
          responsesUids: [],
          address: data['address'],
          fixPrice: data['fix_price'],
          notPrice: data['not_price'],
          dateAndTime: data['date_and_time'],
          freelancer: data['freelancer'],
          remotely: data['remotely'],
          email: data['email'],
          username: data['username'],
          wishes: data['wishes'],
          priceMax: data['price_max'],
          priceMin: data['price_min'],
          category: data['category'],
          ccid: data['ccid'],
          images: data['images'],
          name: data['name'],
          id: data['id'],
          orderStatus: data['order_status'],
          reviewCustomer: '',
          reviewFreelancer: '',
          sees: data['sees'],
          city: data['city'],
          description: data['description'],
          freelancerName: data['freelancer_name'],
          responses: []));
    }
  }

  Future<void> getMyOrders(int uid) async {
    final response =
        await dio.get('${ServerRoutes.host}/getUserActiveOrders', data: {
      'uid': uid,
    });
    final json = jsonDecode(response.data);
    myOrders.clear();
    for (int i = 0; i < json.length; i++) {
      var data = json[i];
      List responses = data['responses'];
      myOrders.add(OrderModel(
        responsesUids: [],
          address: data['address'],
          lat: data['geo_x'],
          long: data['geo_y'],
          dateAndTime: data['date_and_time'],
          uid: data['uid'],
          remotely: data['remotely'],
          freelancer: data['freelancer'],
          email: data['email'],
          username: data['username'],
          wishes: data['wishes'],
          priceMax: data['price_max'],
          fixPrice: data['fix_price'],
          notPrice: data['not_price'],
          priceMin: data['price_min'],
          category: data['category'],
          name: data['name'],
          images: data['images'],
          ccid: data['ccid'],
          id: data['id'],
          orderStatus: data['order_status'],
          sees: data['sees'],
          city: data['city'],
          reviewCustomer: data['review_customer'],
          reviewFreelancer: data['review_freelancer'],
          freelancerName: data['freelancer_name'],
          description: data['description'],
          responses: List.generate(
              responses.length,
              (index) => ResponseFromOrderModel(
                  pid: responses[index]['pid'],
                  id: responses[index]['id'],
                  price: responses[index]['price'],
                  uid: responses[index]['uid'],
                  timestamp: responses[index]['timestamp'],
                  date_and_time: responses[index]['date_and_time'],
                  freelancerName: responses[index]['freelancer_name'],
                  comment: responses[index]['comment']))));
    }
    print(myOrders);
  }
}
