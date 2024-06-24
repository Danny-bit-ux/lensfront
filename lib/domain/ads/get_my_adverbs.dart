import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../ServerRoutes.dart';
import '../../model/ads_model.dart';

class GetMyAdverbs extends GetxController {
  Dio dio = Dio();
  final myAdberbs = Rx<List<AdverbModel>>([]);
  Future<void> getMyAdverbs(uid) async {
    final response = await dio.post('${ServerRoutes.host}/getmyadverbs',
    data: {
      'uid': uid.toString(),
    });
    myAdberbs.value.clear();
    List adv = jsonDecode(response.data);
    for (var adverb in adv)  {
      myAdberbs.value.add(AdverbModel(
        images: adverb['images'],
        address: adverb['address'],
        ccid: adverb['ccid'],
        age: adverb['age'],
        description: adverb['description'],
        drive_type: adverb['drive_type'],
        color: adverb['color'],
        category: adverb['category'],
        category_id: adverb['category_id'],
        cpu: adverb['cpu'],
        brand: adverb['brand'],
        build_type: adverb['build_type'],
        size: adverb['size'],
        screen_size: adverb['screen_size'],
        sex: adverb['sex'],
        square: adverb['square'],
        state: adverb['state'],
        ram: adverb['ram'],
        repair: adverb['repair'],
        rights: adverb['rights'],
        year: adverb['year'],
        type: adverb['type'],
        timestamp: adverb['timestamp'],
        tact_numbers: adverb['tact_numbers'],
        transmission: adverb['transmission'],
        order_type: adverb['order_type'],
        flour: adverb['flour'],
        fuel_supply: adverb['fuel_supply'],
        nm: adverb['nm'],
        memory_hard: adverb['memory_hard'],
        messages: adverb['messages'],
        model: adverb['model'],
        price: adverb['price'],
        phone: adverb['phone'],
        id: adverb['id'],
        uid: adverb['uid'],
        gears: adverb['gears'],
        gpu: adverb['gpu'],
        hp: adverb['hp'],
        killometrs: adverb['killometrs'],
        engine: adverb['engine'],
        engine_cylinders: adverb['engine_cylinders'],
        engine_volume:  adverb['engine_volume'],
      ));
    }
    notifyChildrens();
  }
}