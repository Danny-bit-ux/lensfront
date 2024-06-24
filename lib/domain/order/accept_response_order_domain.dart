import 'package:dio/dio.dart';

import '../../ServerRoutes.dart';


Future<void> acceptResponseOrder({required uid, required pid}) async {
  Dio dio = Dio();
  dio.post('${ServerRoutes.host}/acceptresponseorder',
  data: {
    'uid': uid.toString(),
    'pid': pid.toString()
  });
}