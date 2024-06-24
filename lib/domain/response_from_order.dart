import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../ServerRoutes.dart';

class ResponseFromOrder extends ChangeNotifier {
  Dio dio = Dio();
  Future<void> responseFromOrder({required int pid,required int uid,required int price,required String comment,required String date_and_time,required String timestamp }) async {
    await dio.post('${ServerRoutes.host}/createresponse',data: {
      'pid': pid,
      'uid': uid,
      'price': price,
      'comment': comment,
      'date_and_time': date_and_time,
      'timestamp': timestamp,
    });
  }
}