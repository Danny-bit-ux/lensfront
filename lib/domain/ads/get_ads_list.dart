import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import '../../ServerRoutes.dart';
import '../../model/ads_model.dart';

class GetAdsList extends ChangeNotifier {
  String? category;
  String priceMin = '0';
  String priceMax ='9999999';
  String? ratingMin;
  Dio dio = Dio();
 List<AdverbModel> adverbs=[];
  Future<void> getAdsList() async {
    final response = await dio.get('${ServerRoutes.host}/getadverbs');
    print(response.data);
    adverbs.clear();
    List adv = jsonDecode(response.data);
    for (var adverb in adv)  {
      adverbs.add(AdverbModel(
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
        userName: adverb['user_name'],
        userRating: adverb['user_rating'],
        userReviews: adverb['user_reviews'],
      ));
    }
    notifyListeners();
  }
  Future<void> getSortAdsList(category) async {
    final response = await dio.post('${ServerRoutes.host}/getAdsFromCat',
    data: {
      'category': category,
      'priceMin': priceMin,
      'priceMax':priceMax,
    });
    print(response.data);
    adverbs.clear();
    List adv = jsonDecode(response.data);
    for (var adverb in adv)  {
      adverbs.add(AdverbModel(
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
        userName: adverb['user_name'],
        userRating: adverb['user_rating'],
        userReviews: adverb['user_reviews'],
      ));
    }
    notifyListeners();
  }
  getSortOrders(){
    if(
    category == null
    ) {
      getAdsList();
    }
    else {
    getSortAdsList(category);
    }
    notifyListeners();
  }
  void changeCategory (_cat) {
    category = _cat;
    getSortOrders();
  }
  void clearFilters() {
   priceMin = '0';
  priceMax  = '9999999';
 category   = 'no';
   ratingMin = '0';
  getSortOrders();
  }
}

// 'price': adverbModel.price.toString(),
//       'phone': adverbModel.phone.toString(),
//       'size': adverbModel.size.toString(),
//       'hp': adverbModel.hp.toString(),
//       'messages': adverbModel.messages.toString(),
//       'category': adverbModel.category.toString(),
//       'uid': adverbModel.uid.toString(),
//       'year': adverbModel.year.toString(),
//       'sex': adverbModel.sex.toString(),
//       'age': adverbModel.age.toString(),
//       'color': adverbModel.color.toString(),
//       'timestamp': adverbModel.timestamp.toString(),
//       'description': adverbModel.description.toString(),
//       'address': adverbModel.address.toString(),
//       'model': adverbModel.model.toString(),
//       'brand': adverbModel.brand.toString(),
//       'engine': adverbModel.engine.toString(),
//       'state': adverbModel.state.toString(),
//       'build_type': adverbModel.build_type.toString(),
//       'category_id': adverbModel.category_id.toString(),
//       'cpu': adverbModel.cpu.toString(),
//       'drive_type': adverbModel.drive_type.toString(),
//       'engine_cylinders': adverbModel.engine_cylinders.toString(),
//       'engine_volume': adverbModel.engine_volume.toString(),
//       'flour': adverbModel.flour.toString(),
//       'fuel_supply': adverbModel.fuel_supply.toString(),
//       'gears': adverbModel.gears.toString(),
//       'gpu': adverbModel.gpu.toString(),
//       'killometrs': adverbModel.killometrs.toString(),
//       'memory_hard': adverbModel.memory_hard.toString(),
//       'nm': adverbModel.nm.toString(),
//       'order_type': adverbModel.order_type.toString(),
//       'ram': adverbModel.ram.toString(),
//       'repair': adverbModel.repair.toString(),
//       'rights': adverbModel.rights.toString(),
//       'screen_size': adverbModel.screen_size.toString(),
//       'square': adverbModel.square.toString(),
//       'tact_numbers': adverbModel.tact_numbers.toString(),
//       'transmission': adverbModel.transmission.toString(),
//       'type': adverbModel.type.toString(),