// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/order_controller.dart';
import '../widgets/order_card_widget.dart';

class OrdersFromCatView extends GetView<OrderController> {
  final category;
  final categoryName;
  const OrdersFromCatView({super.key, required this.category, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderController());
    controller.getOrdersFromCategory(categoryName);
    return  WillPopScope(
        onWillPop: () {
      Navigator.pop(context);
      return Future.value(false);
    },
      child: Obx(
          ()=>Scaffold(
          backgroundColor: const Color.fromRGBO(249, 249,249, 1),
          appBar: AppBar(
            title: Text(categoryName.toString()),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: controller.categoryOrders.isNotEmpty? Column(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(controller.categoryOrders.length, (index) => OrderCardWidget(item: controller.categoryOrders[index], myOrders: false, profileModel: null)),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                )
              ],
            ) :const Center(
              child: Text("В данной категории ещё нет заявок",textAlign: TextAlign.center,),
            ),
          ),
        ),
      ),
    );
  }
}
