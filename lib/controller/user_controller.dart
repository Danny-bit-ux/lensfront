import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../ServerRoutes.dart';
import '../domain/user/auth/create_user.dart';


class UserController extends GetxController {
  RxList newMasters = [].obs;
  Dio dio =Dio();
  Future<bool> updateUserPassword(
  {required String newPassword, required String lastPassword}) async {
    final response = await dio.post('${ServerRoutes.host}/updateUserPassword',
    data: {
      'uid': uid.toString(),
      'lastPassword': lastPassword,
      'newPassword': newPassword,
    });
    final data = jsonDecode(response.data);
    return data['success'];
  }
  Future<void> setFreelancer() async {
    dio.post('${ServerRoutes.host}/setFreelancer',
    data: {
      'uid': uid.toString(),
    });
  }
  Future<void> getNewMasters() async {
    final response = await dio.get('${ServerRoutes.host}/lastFreelancers');
    print(response.data);
    newMasters.value = jsonDecode(response.data);
    notifyChildrens();
  }
}