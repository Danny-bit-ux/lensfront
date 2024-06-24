// ignore_for_file: invalid_use_of_protected_member

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../ServerRoutes.dart';
import '../domain/user/auth/create_user.dart';
import '../model/time_model.dart';

class ServicesController extends GetxController {
  @override
  void onInit() {
    getMyOrdersShortList();
    super.onInit();
  }
  Dio dio = Dio();
  RxBool archive = false.obs;
  RxList myServices = [].obs;
  RxList myServicesShort = [].obs;
  RxBool fixPrice = false.obs;
  RxBool hourPrice = false.obs;
  RxBool fixTime = true.obs;
  RxString category = ''.obs;
  RxString globalCategory = ''.obs;
  RxInt categoryId = 0.obs;
  RxList categories = [].obs;
  RxList allServices = [].obs;
  RxList freelancerServices = [].obs;
  RxList servicesByCategory = [].obs;
  RxString searchCategory = 'no'.obs;
  RxString searchPriceMin = '0'.obs;
  RxString searchPriceMax = '9999999'.obs;
  RxString searchRatingMin = '0'.obs;
  RxString searchCity = 'no'.obs;
  Rx<DateTime> requestDay =DateTime.now().obs;
  RxList freelancerBooking = [].obs;
  RxList customerBooking = [].obs;
  RxList archiveServices = [].obs;
  RxList<bool> days = [
    false,
    false,
    false,
    false,
    false,
    false,false,
  ].obs;
  RxList<TimeModel> hours = [
    const TimeModel(title: '00:00', time: 100),
    const TimeModel(title: '01:00', time: 101),
    const TimeModel(title: '02:00', time: 102),
    const TimeModel(title: '03:00', time: 103),
    const TimeModel(title: '04:00', time: 104),
    const TimeModel(title: '05:00', time: 105),
    const TimeModel(title: '06:00', time: 106),
    const TimeModel(title: '07:00', time: 107),
    const TimeModel(title: '08:00', time: 108),
    const TimeModel(title: '09:00', time: 109),
    const TimeModel(title: '10:00', time: 110),
    const TimeModel(title: '11:00', time: 111),
    const TimeModel(title: '12:00', time: 112),
    const TimeModel(title: '13:00', time: 113),
    const TimeModel(title: '14:00', time: 114),
    const TimeModel(title: '15:00', time: 115),
    const TimeModel(title: '16:00', time: 116),
    const TimeModel(title: '17:00', time: 117),
    const TimeModel(title: '18:00', time: 118),
    const TimeModel(title: '19:00', time: 119),
    const TimeModel(title: '20:00', time: 120),
    const TimeModel(title: '21:00', time: 121),
    const TimeModel(title: '22:00', time: 122),
    const TimeModel(title: '23:00', time: 123),
  ].obs;

  RxInt startTime = 0.obs;
  RxInt endTime = 0.obs;

  void setStartTime(int time) {
    startTime.value = time;
    notifyChildrens();
  }
  void setEndTime(int time) {
    endTime.value = time;
    notifyChildrens();
  }

  void setMn(index) {
    days.value[index] = !days.value[index];
    days.refresh();
    notifyChildrens();
  }

  void switcher(RxBool value) {
    value.value = !value.value;
    value.refresh();
    notifyChildrens();

  }
  
  Future<void> bookService({
   required sid,
   required description,
   required date,
    required freelancerId,
}) async {
    dio.post('${ServerRoutes.host}/bookService',
    data: {
      'uid': uid,
      'sid': sid,
      'description': description,
      'date': date,
      'freelancer_id': freelancerId,
    });
  }
//getFreelancerBooking
  Future<void> getMyServices(id) async {
    final response =
    await dio.post('${ServerRoutes.host}/getMyServices', data: {
      'uid': id.toString(),
    });
    myServices.value = jsonDecode(response.data);
    notifyChildrens();
  }
  Future<void> getFreelancerBooking() async {
    final response =
    await dio.post('${ServerRoutes.host}/getFreelancerBooking', data: {
      'uid': uid.toString(),
    });
    freelancerBooking.value = jsonDecode(response.data);

    notifyChildrens();
  }
  Future<void> getCustomerBooking() async {
    final response =
    await dio.post('${ServerRoutes.host}/getCustomerBooking', data: {
      'uid': uid.toString(),
    });
    customerBooking.value = jsonDecode(response.data);

    notifyChildrens();
  }
  Future<void> getCategoryServices(_categoryName) async {
    final response =
    await dio.post('${ServerRoutes.host}/getServicesByCategoryName', data: {
      'category_name': _categoryName,
    });
    servicesByCategory.value = jsonDecode(response.data);
    notifyChildrens();
  }
  Future<void> getFreelancerServices (freelancerUid) async {
    final response =
    await dio.post('${ServerRoutes.host}/getMyServices', data: {
      'uid': freelancerUid.toString(),
    });
    freelancerServices.value = jsonDecode(response.data);
    freelancerServices.refresh();
    notifyChildrens();
  }
  Future<void> getAllServices(str) async {
    var requestData ={
      'price_min':  (int.parse(searchPriceMin.value)-1).toString(),
      'price_max': (int.parse(searchPriceMax.value)+1).toString(),
      'category': searchCategory.value,
      'rating_min': searchRatingMin.value,
      'str': str,
      'city': searchCity.value,
    };
    final response =
    await dio.post('${ServerRoutes.host}/services',
    data: requestData);
    print(requestData);
    print(allServices.value.length);
    allServices.value = jsonDecode(response.data);
    notifyChildrens();
  }
  Future<void> getMyOrdersShortList() async {
    final response = await dio.post('${ServerRoutes.host}/getMyServicesShort',
    data: {
      'uid': uid,
    });
    print(response.data);
    myServicesShort.value = jsonDecode(response.data);
    notifyChildrens();

  }
  void changeCity (city) {
    searchCity.value = city;
    getAllServices('');
    notifyChildrens();
  }
  void clearFilters() {
    searchPriceMin.value = '0';
    searchPriceMax.value = '9999999';
    searchCategory.value = 'no';
    searchRatingMin.value = '0';
    searchCity.value = 'no';
    getAllServices('');
  }
  Future<void> createServise({required name, required categoryId, required categoryName, required description, required price,required String globalCategory}) async {
    dio.post('${ServerRoutes.host}/createService',
    data: {
      'uid': uid,
      'name': name,
      'category_id': 0,
      'category_name': categoryName,
      'description': description,
          'price_min': price,
        'time': '$startTime$endTime',
        'monday': days.value[0].toString(),
        'tuesday':days.value[1].toString(),
        'wednesday':days.value[2].toString(),
        'thursday':days.value[3].toString(),
        'friday':days.value[4].toString(),
      'saturday':days.value[5].toString(),
      'sunday':days.value[6].toString(),
      'fixPrice': fixPrice.value.toString(),
      'hourPrice': hourPrice.value.toString(),
      'global_category': globalCategory,
    });
  }
  Future<void> getCategoriesList() async {
    final response = await dio.get("${ServerRoutes.host}/categories");
    categories.value = jsonDecode(response.data);
    print(categories.value);
    notifyChildrens();
  }
  Future<void> getMyArchiveServices() async {
  final response = await  dio.post('${ServerRoutes.host}/archiveServices',
    data: {
      'uid':uid,
    });
  archiveServices.value = jsonDecode(response.data);
  notifyChildrens();
  }
  void selectType(bool type) {
    archive.value = type;
    notifyChildrens();
  }
  Future<void> archiveService(id) async {
    await dio.post('${ServerRoutes.host}/archiveService',
    data: {'id': id});
    await getMyArchiveServices();
    await getMyServices(uid);
  }
  Future<void> activateService(id) async {
    await dio.post('${ServerRoutes.host}/activateService',
    data: {
      'id': id,
    });
    await getMyArchiveServices();
    await getMyServices(uid);
  }
}
