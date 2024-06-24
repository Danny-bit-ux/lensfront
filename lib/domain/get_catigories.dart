import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../ServerRoutes.dart';
import '../models/category_model.dart';

class GetCatigories extends ChangeNotifier {
  List<Category_model> categoryList = [];

  final Dio _dio = Dio();
  //Future<List<Category_model>?> getCategories() async{
  Future<void> getCat() async {
    if(categoryList.length<2 ) {
    final response = await _dio.get('${ServerRoutes.host}/getcategories');
    final json = jsonDecode(response.data);
    List data = json['categories'];
    data.forEach((element) {categoryList.add(Category_model.fromJson(element)); });
    //categoryList = List.generate(data.length, (index) {
     // List sub=data[index]['subcategories'];
     // List<Sub_category_model> subCat=GetSubcat(subcat: sub).getSubcat(sub);
      //return Category_model(id: data[index]['id'], name: data[index]['name'],
        //  subcategories: GetSubcat(subcat: sub).getSubcat(sub));
    //});
    print(categoryList);
    //for(int i = 0; i < data.length; i++) {
    // List sub=data[i]['subcategories'];
    // print(sub);
    //categoryList.add(Category_model(id: data[i]['id'], name: data[i]['name'], categories: List.generate(sub.length, (index) => Category_model(id: sub[index]['id'], name: sub[index]['name']))));
  }
//   print(categoryList);
  notifyListeners(); }
}

// Future <void> getCategories() async {
//   String endPoint = NetStrings.endPointCatigories;
//   print(endPoint);
//   try {
//     await DioHelper.dio.get(endPoint).then((value) =>
//     {
//       value.data.forEach((itemJson) {
//         categoryList.add(Category_model.fromJson(itemJson));
//       })
//     });
//     print('catlist' + categoryList.toString());
//     notifyListeners();
//return categoryList;

class GetSubcat {
  final List subcat;
   List<Sub_category_model> subcategoryList = [];
   GetSubcat({required this.subcat});
   getSubcat(List sublist)
  {
    subcategoryList= List.generate(sublist.length, (index) {
      List sub=sublist[index]['subcategories'];
      return(Sub_category_model(id: sublist[index]['id'], name: sublist[index]['name'],subcategories: GetSubcat(subcat: sub).getSubcat(sub)));
    });
        //subcategories: List.generate(sub.length, (index2) {)
         // List subsub=data[index2]['subcategories'];
          //print(subsub);
          //return(Sub_category_model(id: sublist[index1]['id'], name: subsub[index2]['name'],));}))));
    return(subcategoryList);
  }

}