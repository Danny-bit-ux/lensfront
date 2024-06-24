import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import '../../ServerRoutes.dart';
import '../../model/ads_model.dart';

class CreateAdverb extends ChangeNotifier {
  Dio dio = Dio();
  Future<void> createAdverb(AdverbModel adverbModel, photos) async {
    Uuid uuid = const Uuid();
    String ccid = await uuid.v1();
    if (photos.isEmpty) {
      print('No images selected.');
      return;
    }

    List<Map<String, dynamic>> images = [];
    int index = 1;
    for (var imageFile in photos) {
      List<int> bytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(bytes);
      images.add({'name': '$index.jpg', 'data': base64Image});
      index++;
    }

    var folderName = ccid;

    final response = await dio.post('${ServerRoutes.host}/createadverb',
        options: Options(headers: {
          'folder-name': folderName,
        }),
        data: {
          'price': adverbModel.price.toString(),
          'name': adverbModel.name.toString(),
          'phone': adverbModel.phone.toString(),
          'size': adverbModel.size.toString(),
          'hp': adverbModel.hp.toString(),
          'messages': adverbModel.messages.toString(),
          'category': adverbModel.category.toString(),
          'uid': adverbModel.uid.toString(),
          'year': adverbModel.year.toString(),
          'sex': adverbModel.sex.toString(),
          'age': adverbModel.age.toString(),
          'color': adverbModel.color.toString(),
          'timestamp': adverbModel.timestamp.toString(),
          'description': adverbModel.description.toString(),
          'address': adverbModel.address.toString(),
          'model': adverbModel.model.toString(),
          'brand': adverbModel.brand.toString(),
          'engine': adverbModel.engine.toString(),
          'state': adverbModel.state.toString(),
          'build_type': adverbModel.build_type.toString(),
          'category_id': adverbModel.category_id.toString(),
          'cpu': adverbModel.cpu.toString(),
          'drive_type': adverbModel.drive_type.toString(),
          'engine_cylinders': adverbModel.engine_cylinders.toString(),
          'engine_volume': adverbModel.engine_volume.toString(),
          'flour': adverbModel.flour.toString(),
          'fuel_supply': adverbModel.fuel_supply.toString(),
          'gears': adverbModel.gears.toString(),
          'gpu': adverbModel.gpu.toString(),
          'killometrs': adverbModel.killometrs.toString(),
          'memory_hard': adverbModel.memory_hard.toString(),
          'nm': adverbModel.nm.toString(),
          'order_type': adverbModel.order_type.toString(),
          'ram': adverbModel.ram.toString(),
          'repair': adverbModel.repair.toString(),
          'rights': adverbModel.rights.toString(),
          'screen_size': adverbModel.screen_size.toString(),
          'square': adverbModel.square.toString(),
          'tact_numbers': adverbModel.tact_numbers.toString(),
          'transmission': adverbModel.transmission.toString(),
          'type': adverbModel.type.toString(),
          'images': images,
        });
  }
}
