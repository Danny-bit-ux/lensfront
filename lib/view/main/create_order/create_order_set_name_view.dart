import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../controller/order_controller.dart';
import '../../../domain/user/auth/create_user.dart';
import '../../../domain/user/get_user_profile.dart';
import '../../main_view.dart';
import '../../widgets/custom_textfield_widget.dart';
import '../../widgets/top_row_widget.dart';
import 'create_order_other_propitries_view.dart';
import 'create_order_set_name.dart';
import 'create_order_set_time_view.dart';


TextEditingController _nameController = TextEditingController();
TextEditingController _emailController = TextEditingController();

//double latitude = 0.0;
// double longitude = 0.0;
class CreateOrderSetNameAndEmailView extends GetView<OrderController> {
  final String categoryName;
  final String orderName;
  final String dateAndTime;
  final String address;
  final String priceMin;
  final String priceMax;
  final String categoryId;
  final String parentCategoryId;
  final String sup;
  final bool fixPrice;
  final bool notPrice;
  final List photos;
  final bool remotely;
  final String description;
  final double latitude;
  final double longitude;
  const CreateOrderSetNameAndEmailView(
      {super.key,
      required this.categoryName,
      required this.address,
      required this.dateAndTime,
      required this.orderName,
      required this.priceMin,
      required this.priceMax,
      required this.sup,
      required this.remotely,
      required this.categoryId,
      required this.parentCategoryId,
      required this.description,
      required this.fixPrice,
      required this.notPrice,
      required this.photos,
      required this.longitude,
      required this.latitude});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderController());
    final userData = context.read<GetUserProfile>();
    _emailController.text = userData.userModel!.email;
    _nameController.text = userData.userModel!.name;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopRowWidget(text: 'Шаг 7 из 7'),
              const SizedBox(
                height: 16,
              ),
              Text(
                categoryName,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xff808080),
                ),
              ),
              const Text(
                'Заказ почти готов',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFieldWidget(
                  controller: _nameController,
                  text: 'Введите имя',
                  password: false),
              const SizedBox(
                height: 10,
              ),
              CustomTextFieldWidget(
                  controller: _emailController,
                  text: 'Введите email',
                  password: false),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 45.0, right: 10, left: 10),
        child: GestureDetector(
          onTap: () async {
            _emailController.text.isEmpty || _nameController.text.isEmpty
                ? null
                : await {
                    controller.createOrder(
                        photos: photos,
                        address: address,
                        description: description,
                        not_price: notPrice,
                        fix_price: fixPrice,
                        categoryName: categoryName,
                        uid: int.parse(uid),
                        name: orderName,
                        timestamp: DateTime.now().toString(),
                        categoryId: parentCategoryId,
                        category_sup: categoryId,
                        date_and_time: dateAndTime,
                        geo_x: latitude.toString(),
                        geo_y: longitude.toString(),
                        geo_del_x: 0,
                        geo_del_y: 0,
                        price_min: priceMin.isEmpty ? null : priceMin,
                        price_max: priceMax.isEmpty ? null : priceMax,
                        wishes: sup,
                        username: _nameController.text,
                        order_status: 'active',
                        email: _emailController.text,
                        city: 'Moscow',
                        remotely: remotely),



                    Future.delayed(const Duration(milliseconds: 100), () {
                      controller.getMyActiveOrders(uid);
                    }),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainView()))
                  };
          },
          child: Container(
            height: 52,
            width: MediaQuery.of(context).size.width - 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color:
                  _emailController.text.isEmpty || _nameController.text.isEmpty
                      ? const Color(0xffEBEBEB)
                      : const Color(0xffF14F44),
            ),
            child: Center(
              child: Text('Создать',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: _emailController.text.isEmpty ||
                            _nameController.text.isEmpty
                        ? Colors.black
                        : Colors.white,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
