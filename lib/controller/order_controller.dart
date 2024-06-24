import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../ServerRoutes.dart';
import '../domain/user/auth/create_user.dart';
import '../model/order_model.dart';
import '../model/response_from_order_model.dart';

class OrderController extends GetxController {
  @override
  void onInit() {
    getReviews();
    super.onInit();
  }
  Dio dio = Dio();
  RxBool service = false.obs;
  RxList categories = [].obs;
  RxList workOrders = [].obs;
  RxList myResponses = [].obs;
  RxList completeOrders = [].obs;
  RxList categoryOrders = [].obs;
  RxBool archive = false.obs;
  RxList servicesFromOrder = [].obs;
  RxList freelancerReviews = [].obs;
  Rx order = OrderModel(
    responsesUids: [],
      lat: '0.0',
      long: '0.0',
          uid: '',
          freelancer: '',
          freelancerName: '',
          remotely: '',
          email: '',
          username: '',
          wishes: '',
          priceMax: '',
          priceMin: '',
          category: '',
          address: '',
          name: '',
          id: '',
          orderStatus: '',
          city: '',
          sees: '',
          responses: [],
          description: '',
          dateAndTime: '',
          reviewCustomer: '',
          reviewFreelancer: '',
          notPrice: '',
          fixPrice: '',
          ccid: '',
          images: '')
      .obs;
  final allOrders = Rx<List<OrderModel>>([]);
  RxMap orderReview = {}.obs;
  final myActiveOrders = Rx<List<OrderModel>>([]);
  final myArchiveOrders = Rx<List<OrderModel>>([]);
  Future<void> getOrderInfo(id) async {
    final response = await dio.post('${ServerRoutes.host}/getOrderInfo', data: {
      'id': id.toString(),
    });
    final data = jsonDecode(response.data);
    print(response.data);
    List responses = data['responses'];
    order.value = OrderModel(
      responsesUids: [],
        lat: data['geo_x'],
        long: data['geo_y'],
        uid: data['uid'],
        freelancer: data['freelancer'],
        freelancerName: data['freelancer_name'],
        remotely: data['remotely'],
        email: data['email'],
        username: data['username'],
        wishes: data['wishes'],
        priceMax: data['price_max'],
        priceMin: data['price_min'],
        category: data['category'],
        address: data['address'],
        name: data['name'],
        id: id,
        orderStatus: data['order_status'],
        city: data['city'],
        sees: data['sees'],
        responses: List.generate(
            responses.length,
            (index) => ResponseFromOrderModel(
                pid: responses[index]['pid'],
                id: responses[index]['id'],
                freelancerName: responses[index]['freelancer_name'],
                price: responses[index]['price'],
                uid: responses[index]['uid'],
                timestamp: responses[index]['timestamp'],
                date_and_time: responses[index]['date_and_time'],
                comment: responses[index]['comment'])),
        description: data['description'],
        dateAndTime: data['date_and_time'],
        reviewCustomer: data['review_customer'],
        reviewFreelancer: data['review_freelancer'],
        notPrice: data['not_price'],
        fixPrice: data['fix_price'],
        ccid: data['ccid'],
        images: data['images']);
    notifyChildrens();
  }

  Future<void> getWorkOrders(uid) async {
    final response =
        await dio.post('${ServerRoutes.host}/getworkorders', data: {
      'uid': uid.toString(),
    });
    workOrders.value = jsonDecode(response.data);
    print('work orders ${response.data}');
    notifyChildrens();
  }

  Future<void> getMyResponses(uid) async {
    final response =
        await dio.post('${ServerRoutes.host}/getmyresponses', data: {
      'uid': uid.toString(),
    });
    myResponses.value = jsonDecode(response.data);
    notifyChildrens();
  }

  Future<void> deleteMyResponse(pid) async {
    await dio.post('${ServerRoutes.host}/deleteMyResponse', data: {
      'pid': pid,
    });
    getMyResponses(uid);
  }

  Future<void> deleteOrder(pid) async {
    await dio.get('${ServerRoutes.host}/deleteOrder', data: {
      'pid': pid.toString(),
    });
  }

  Future<void> orderContinueFreelancer(pid) async {
    dio.post('${ServerRoutes.host}/completeFreelancer', data: {
      'pid': pid.toString(),
    });
  }

  void changeToServices() {
    service.value = true;
    notifyChildrens();
  }

  void changeToResponses() {
    service.value = false;
    notifyChildrens();
  }

  Future<void> getServicesByOrder(categoryName) async {
    final response = await dio.post('${ServerRoutes.host}/getServicesByCategoryName', data: {
      'category_name': categoryName,
    });
    servicesFromOrder.value = jsonDecode(response.data);
  }

  Future<void> orderContinueCustomer(pid) async {
    dio.post('${ServerRoutes.host}/completeCustomer', data: {
      'pid': pid.toString(),
    });
  }

  Future<void> getCompleteOrders() async {
    final response =
        await dio.post('${ServerRoutes.host}/getCompleteOrders', data: {
      'uid': uid.toString(),
    });
    completeOrders.value = jsonDecode(response.data);
    notifyChildrens();
  }

  Future<void> getMyActiveOrders(uid) async {
    final response =
        await dio.get('${ServerRoutes.host}/getUserActiveOrders', data: {
      'uid': uid.toString(),
    });
    final json = jsonDecode(response.data);
    print(response.data);
    myActiveOrders.value.clear();
    for (int i = 0; i < json.length; i++) {
      var data = json[i];
      List responses = data['responses'];
      myActiveOrders.value.add(OrderModel(
          dateAndTime: data['date_and_time'],
          responsesUids: [],
          uid: data['uid'],
          lat: data['geo_x'],
          long: data['geo_y'],
          images: data['images'],
          ccid: data['ccid'],
          address: data['address'],
          notPrice: data['not_price'],
          fixPrice: data['fix_price'],
          remotely: data['remotely'],
          freelancer: data['freelancer'],
          email: data['email'],
          username: data['username'],
          wishes: data['wishes'],
          priceMax: data['price_max'],
          priceMin: data['price_min'],
          category: data['category'],
          reviewCustomer: data['review_customer'],
          reviewFreelancer: data['review_freelancer'],
          name: data['name'],
          id: data['id'],
          orderStatus: data['order_status'],
          sees: data['sees'],
          city: data['city'],
          freelancerName: data['freelancer_name'],
          description: data['description'],
          responses: List.generate(
              responses.length,
              (index) => ResponseFromOrderModel(
                freelancerName: responses[index]['freelancer_name'],
                  pid: responses[index]['pid'],
                  id: responses[index]['id'],
                  price: responses[index]['price'],
                  uid: responses[index]['uid'],
                  timestamp: responses[index]['timestamp'],
                  date_and_time: responses[index]['date_and_time'],
                  comment: responses[index]['comment']))));
    }
    myActiveOrders.refresh();
    notifyChildrens();
  }

  Future<void> getMyArchiveOrders(int uid) async {
    final response =
        await dio.get('${ServerRoutes.host}/getMyArchiveOrders', data: {
      'uid': uid,
    });
    final json = jsonDecode(response.data);
    myArchiveOrders.value.clear();
    for (int i = 0; i < json.length; i++) {
      var data = json[i];
      List responses = data['responses'];
      myArchiveOrders.value.add(OrderModel(
        responsesUids: [],
          dateAndTime: data['date_and_time'],
          ccid: data['ccid'],
          images: data['images'],
          fixPrice: data['fix_price'],
          notPrice: data['not_price'],
          address: data['address'],
          uid: data['uid'],
          remotely: data['remotely'],
          lat: data['geo_x'],
          long: data['geo_y'],
          freelancer: data['freelancer'],
          email: data['email'],
          username: data['username'],
          wishes: data['wishes'],
          priceMax: data['price_max'],
          priceMin: data['price_min'],
          category: data['category'],
          reviewCustomer: data['review_customer'],
          reviewFreelancer: data['review_freelancer'],
          name: data['name'],
          id: data['id'],
          orderStatus: data['order_status'],
          sees: data['sees'],
          city: data['city'],
          freelancerName: data['freelancer_name'],
          description: data['description'],
          responses: []));
    }
    myArchiveOrders.refresh();
    notifyChildrens();
  }

  void setArchive(value) {
    archive.value = value;
    notifyChildrens();
  }

  Future<void> getCategoriesList() async {
    final response = await dio.get("${ServerRoutes.host}/categories");
    categories.value = jsonDecode(response.data);
    notifyChildrens();
  }

  Future<void> createOrder({
    required int uid,
    required List photos,
    required bool not_price,
    required String address,
    required bool fix_price,
    required String categoryName,
    required String name,
    required String timestamp,
    required String categoryId,
    required String category_sup,
    required String date_and_time,
    required  geo_x,
    required  geo_y,
    required double geo_del_x,
    required double geo_del_y,
    required price_min,
    required price_max,
    required String wishes,
    required String username,
    required String order_status,
    required String email,
    required String city,
    required bool remotely,
    required String description,
  }) async {
    Uuid uuid = const Uuid();
    String ccid = await uuid.v1();
    List<Map<String, dynamic>> images = [];
    int index = 1;
    for (var imageFile in photos) {
      String fileName = imageFile.path.split('/').last;
      List<int> bytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(bytes);
      images.add({'name': '$index.jpg', 'data': base64Image});
      index++;
    }

    var folderName = ccid;

    Dio dio = Dio();
    await dio.post('${ServerRoutes.host}/createorder',
        options: Options(headers: {
          'folder-name': folderName,
        }),
        data: {
          'uid': uid,
          'fix_price': fix_price,
          'ccid': ccid,
          'not_price': not_price,
          'name': name,
          'images': images,
          'timestamp': timestamp,
          'category': categoryName,
          'category_sup': category_sup,
          'address': address,
          'category_id': categoryId,
          'date_and_time': date_and_time,
          'geo_x': geo_x,
          'geo_y': geo_y,
          'geo_del_x': geo_del_x,
          'geo_del_y': geo_del_y,
          'price_min': price_min,
          'price_max': price_max,
          'wishes': wishes,
          'username': username,
          'order_status': order_status,
          'email': email,
          'city': city,
          'remotely': remotely,
          'description': description,
        });
  }

  Future<int> getReviewFromOrderId(pid) async {
    final response =
        await dio.post('${ServerRoutes.host}/getReviewFromId', data: {
      'pid': pid.toString(),
      'uid': uid.toString(),
    });
    orderReview.value = await jsonDecode(response.data);
    int rating = int.parse(orderReview['rating']);
    notifyChildrens();
    return rating;
  }

  RxList reviews = [].obs;
  RxInt rating = 0.obs;
  Future<void> createReviewFreelancer({
    required uid,
    required senderUid,
    required pid,
    required comment,
    required rating,
  }) async {
    dio.post('${ServerRoutes.host}/createReviewFreelancer', data: {
      'uid': uid,
      'sender_uid': senderUid,
      'pid': pid,
      'comment': comment,
      'rating': rating,
    });
    getCompleteOrders();
    notifyChildrens();
  }

  Future<void> createReviewCustomer({
    required uid,
    required senderUid,
    required pid,
    required comment,
    required rating,
  }) async {
    dio.post('${ServerRoutes.host}/createReviewCustomer', data: {
      'uid': uid.toString(),
      'sender_uid': senderUid,
      'pid': pid,
      'comment': comment,
      'rating': rating,
    });
    Future.delayed(const Duration(seconds: 1), () {
      getMyArchiveOrders(uid);
      notifyChildrens();
    });
  }

  void selectRating(int newRating) {
    rating.value = newRating;
    notifyChildrens();
  }

  Future<void> getReviews() async {
    final response = await dio.post('${ServerRoutes.host}/getMyReviews', data: {
      'uid': uid.toString(),
    });
    notifyChildrens();
    reviews.value = jsonDecode(response.data);
  }

  Future<void> getFreelancerReviews(freelancerUid) async {
    final response = await dio.post('${ServerRoutes.host}/getMyReviews', data: {
      'uid': freelancerUid.toString(),
    });
    notifyChildrens();
    freelancerReviews.value = jsonDecode(response.data);
  }

  Future<void> getAllOrders(str) async {
    final response = await dio.get('${ServerRoutes.host}/getorders',data: {
      'str': str,
    });
    List json = jsonDecode(response.data);
    allOrders.value.clear();
    for (int i = 0; i < json.length; i++) {
      var data = json[i];
      allOrders.value.add(OrderModel(
          lat: data['geo_x'],
          long: data['geo_y'],
          uid: data['uid'],
          address: data['address'],
          fixPrice: data['fix_price'],
          notPrice: data['not_price'],
          dateAndTime: data['date_and_time'],
          freelancer: data['freelancer'],
          remotely: data['remotely'],
          email: data['email'],
          username: data['username'],
          wishes: data['wishes'],
          priceMax: data['price_max'],
          priceMin: data['price_min'],
          category: data['category'],
          ccid: data['ccid'],
          images: data['images'],
          name: data['name'],
          id: data['id'],
          orderStatus: data['order_status'],
          reviewCustomer: '',
          reviewFreelancer: '',
          sees: data['sees'],
          city: data['city'],
          description: data['description'],
          freelancerName: data['freelancer_name'],
          responses: [], responsesUids: []));
      notifyChildrens();
      allOrders.refresh();
    }
    notifyChildrens();
  }

  Future getOrdersFromCategory(category) async {
    final response =
        await dio.post('${ServerRoutes.host}/getOrdersFromGlobalCategory', data: {
      'id': category,
    });

    var json = jsonDecode(response.data);
    json = json;
    categoryOrders.clear();
    for (int i = 0; i < json.length; i++) {
      var data = json[i];
      categoryOrders.add(OrderModel(
        responsesUids: [],
          lat: data['geo_x'],
          long: data['geo_y'],
          fixPrice: data['fix_price'],
          notPrice: data['not_price'],
          dateAndTime: data['date_and_time'],
          description: data['description'],
          uid: data['uid'],
          remotely: data['remotely'],
          freelancer: data['freelancer'],
          email: data['email'],
          username: data['username'],
          wishes: data['wishes'],
          priceMax: data['price_max'],
          priceMin: data['price_min'],
          category: data['category'],
          name: data['name'],
          id: data['id'],
          reviewFreelancer: '',
          address: data['address'],
          reviewCustomer: '',
          orderStatus: data['order_status'],
          sees: data['sees'],
          city: data['city'],
          ccid: data['ccid'],
          images: data['images'],
          freelancerName: data['freelancer_name'],
          responses: []));
    }
    notifyChildrens();
  }
  Future<void> updateOrder(id,min,max,name,location,desc) async {
  await  dio.post("${ServerRoutes.host}/updateOrder",data: {
    'id': id,
    'min': min,
    'max': max,
    'location': location,
    'desc': desc
  });
  }
}
