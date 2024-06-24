import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../ServerRoutes.dart';

class RegistrationController extends GetxController {
  Dio dio = Dio();
  RxList categories = [].obs;
  RxList selectedCategories = [].obs;
  RxInt expandedTileIndex = (-1).obs;

  Future<void> getCategoriesList() async {
    final response = await dio.get("${ServerRoutes.host}/categories");
    categories.value = jsonDecode(response.data);
    notifyChildrens();
  }

  void toggleCategorySelection(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  void togglePodSelection(String pod) {
    if (selectedCategories.contains(pod)) {
      selectedCategories.remove(pod);
    } else {
      selectedCategories.add(pod);
    }
  }

  void setExpandedTileIndex(int index) {
    expandedTileIndex.value = index;
  }
}
