
import 'package:newlensfront/model/response_from_order_model.dart';

class OrderModel {
  final fixPrice;
  final notPrice;
  final  name;
  final  freelancerName;
  final  uid;
  final  id;
  final  category;
  final  priceMin;
  final  priceMax;
  final  wishes;
  final  username;
  final  email;
  final  orderStatus;
  final  sees;
  final  remotely;
  final  city;
  final  description;
  final  freelancer;
  final dateAndTime;
  final reviewFreelancer;
  final reviewCustomer;
  final ccid;
  final images;
  final address;
  final lat;
  final long;
  final responsesUids;
//  final customerRating;
  final List<ResponseFromOrderModel> responses;
  OrderModel(
      {required this.uid,
      required this.freelancer,
      required this.freelancerName,
      required this.remotely,
      required this.email,
      required this.username,
      required this.wishes,
      required this.priceMax,
      required this.priceMin,
      required this.category,
        required this.address,
      required this.name,
      required this.id,
      required this.orderStatus,
      required this.city,
      required this.sees,
      required this.responses,
      required this.description,
        required this.dateAndTime,
        required this.reviewCustomer,
        required this.reviewFreelancer,
        required this.notPrice,
        required this.fixPrice,
        required this.ccid,
        required this.images,
        required this.long,
        required this.lat,
        required this.responsesUids
     //   required this.customerRating
      });
  @override
  String toString() {
    // TODO: implement toString
    return '$uid, $remotely, $email, $username, $wishes, $priceMin, $priceMax, $category, $name, $id, $orderStatus, $sees, $responses';
  }
}
