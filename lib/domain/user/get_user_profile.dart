import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../ServerRoutes.dart';
import '../../model/other_user_model.dart';
import '../../model/user_model.dart';

class GetUserProfile extends ChangeNotifier {
  UserModel? userModel;
  Dio dio = Dio();
  var oldResponse = false;
  Future getUserProfile(id) async {
    if (oldResponse == true) {
    } else {
      final response = await dio.get('${ServerRoutes.host}/getuserdata', data: {
        'id': int.parse(id.toString()),
      });

      final data = jsonDecode(response.data);
      userModel = UserModel(
          email: data['email'],
          city: data['city'],
          password_hash: data['password_hash'],
          name: data['name'],
          email_succes: data['email_succes'],
          rating: data['rating'],
          servises: data['servises'],
          client_visiting: data['client_visiting'],
          about_me: data['about_me'],
          experience: data['experience'],
          education: data['education'],
          spheres: data['spheres'],
          freelancer: data['freelancer'],
          skills: data['skills'],
          avatar: data['avatar'],
          date_of_burn: data['date_of_burn'],
          country: data['country'],
          age: data['age'],
          last_login: data['last_login'],
          reviews: data['reviews']);
      notifyListeners();
      oldResponse = true;
    }
  }

  Future<OtherUserModel> getOtherUserProfile(id) async {
    final response =
        await dio.post('${ServerRoutes.host}/getOtherUserInfo', data: {
      'uid': id,
    });
    final data = jsonDecode(response.data);
    return OtherUserModel(
      city: data['city'],
      name: data['name'],
      rating: data['rating'],
      clientVisiting: data['client_visiting'],
      aboutMe: data['about_me'],
      experience: data['experience'],
      education: data['education'],
      freelancer: data['freelancer'],
      skills: data['skills'],
      uid: data['uid'],
      emailSuccess: true,
    );
  }
}
