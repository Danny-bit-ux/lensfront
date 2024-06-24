import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../ServerRoutes.dart';

var uid;

class CreateUser extends ChangeNotifier {
  Dio dio = Dio();

  Future<int> createUser(
      {required var name,
      required var email,
      required var age,
      required var freelancer,
      required var last_login,
      required var password_hash,
      required var city,
      required var country,
      required var date_of_burn,
      required var avatar,
      required var spheres,
      required var skills,
      required var education,
      required var experience,
      required var about_me,
      required var client_visiting,
      required var servises,
      required var rating,
      required var reviews,
      required List categories,
      required var email_succes}) async {
    final response = await dio.post('${ServerRoutes.host}/createuser', data: {
      'name': name,
      'email': email,
      'age': age,
      'freelancer': freelancer,
      'last_login': last_login,
      'password_hash': password_hash,
      'city': city,
      'country': country,
      'date_of_burn': date_of_burn,
      'avatar': avatar,
      'spheres': spheres,
      'skills': skills,
      'education': education,
      'experience': experience,
      'about_me': about_me,
      'client_visiting': client_visiting,
      'servises': servises,
      'rating': rating,
      'reviews': reviews,
      'email_succes': email_succes,
      'categories': categories,
    });
    var data = await jsonDecode(response.data);
    uid = data['uid'].toString();
    notifyListeners();
    return data['uid'];
  }

  Future<dynamic> authUserFromEmail(String email, String password) async {
    final response = await dio.post('${ServerRoutes.host}/authuser', data: {
      'email': email,
      'password': password,
    });
    var data = await jsonDecode(response.data);
    if (data['success'] == true) {
      uid = data['uid'];
      notifyListeners();
      return data['uid'];
    }
    return null;
  }
}
