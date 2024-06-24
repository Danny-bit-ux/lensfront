import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/order_controller.dart';
import '../../domain/user/auth/create_user.dart';
import '../main/home_view.dart';
import '../main/profile/my_profile/my_order_info_view.dart';

class WorkOrdersListView extends GetView<OrderController> {
  const WorkOrdersListView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderController());
    controller.getWorkOrders(uid);
   // controller.getMyResponses(3);
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      appBar: AppBar(),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: List.generate(controller.workOrders.length, (index) {
              final item = controller.workOrders[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: Container(
                  width: MediaQuery.of(context).size.width - 32,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['order_category'],
                          style: GoogleFonts.inter(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          upperfirst(item['order_name']),
                          style: GoogleFonts.inter(
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          '${item['order_price_min']}-${item['order_price_max']}\$',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(item['order_date_and_time']),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Время: ${item['date_time']}'),
                        Text('Ваша цена: ${item['price']}'),
                        Text('Ваш комментарий: ${item['comment']}'),
                        const SizedBox(
                          height: 8,
                        ),
                        item['freelancer_approve'] == '1' ||  item['freelancer_approve'] == 1? Container(
                          height: 52,
                          width: MediaQuery.of(context).size.width-32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black),
                          ),
                          child: const Center(
                            child: Text('Ожидаем подтверждение заказчика'),
                          ),
                        ) :
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDialog(context: context, builder: (BuildContext context) {
                                  return const CustomAlert(title: 'Вы уверены что хотите отказаться от выполнения заказа?', onTap: null);
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                width: MediaQuery.of(context).size.width / 2 - 32,
                                child:  Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: Text('Отказаться',style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),),),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            GestureDetector(
                              onTap: () {
                                print(item['id']);
                               showDialog(context: context, builder: (BuildContext context) {
                                 return CustomAlert(title: 'Вы уверены что хотите завершить заказ?', onTap: controller.orderContinueFreelancer(item['pid']));
                               });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                width: MediaQuery.of(context).size.width / 2 - 32,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: Text('Завершить',style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),)),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class CustomWorkAlert extends GetView<OrderController> {
  final pid;
  const CustomWorkAlert({super.key,required this.pid});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderController());
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content:   Container(
        height: 120,
        width: MediaQuery.of(context).size.width -32,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Center(
                child: Text('Вы уверены что хотите завершить заказ?'),
              ),
              const SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {

                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: MediaQuery.of(context).size.width / 3 - 32,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: Text('Да')),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12,),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: MediaQuery.of(context).size.width / 3 - 32,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: Text('Нет',style: TextStyle(
                            color: Colors.white
                        ),)),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
