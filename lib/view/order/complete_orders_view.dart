import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../controller/order_controller.dart';
import '../main/home_view.dart';
import '../main/profile/my_profile/my_orders_view.dart';
import 'create_review_view.dart';

class CompleteOrdersView extends GetView<OrderController> {
  const CompleteOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderController());
    controller.getCompleteOrders();
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      appBar: AppBar(
        title: const Text('Завершённые заказы'),
        centerTitle: true,
      ),
      body: Obx(
            () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: List.generate(controller.completeOrders.length, (index) {
              final item = controller.completeOrders[index];
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
                          '${item['order_price_min']}-${item['order_price_max']}€',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(item['order_date_and_time']),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Время: ${item['date_time']}'.substring(0,10)),
                        Text('Ваша цена: ${item['price']}€'),
                        Text('Ваш комментарий: ${item['comment']}'),
                        const SizedBox(
                          height: 8,
                        ),
                        item['review_freelancer'] == 'null' ||  item['review_freelancer'] == '0' ||  item['review_freelancer'] == null?
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateReviewView(
                                  freelancer: true,
                                  recipientUid: item['order_uid'],
                                  pid: item['pid'],
                                )));
                              },
                              child: Container(
                                height: 52,
                                width: MediaQuery.of(context).size.width -32,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text(
                                    'Оставить отзыв',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ) : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext
                                    context) {
                                      return MyOrdersAlert(
                                        pid: item['id'],
                                      );
                                    });
                              },
                              child: Container(
                                height: 52,
                                width: MediaQuery.of(context).size.width/2 -32,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text(
                                    'Смотреть отзыв',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext
                                    context) {
                                      return AlertDialog(
                                        contentPadding: EdgeInsets.zero,
                                        content: Container(
                                          height: 320,
                                          width: MediaQuery.of(context).size.width - 12,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Center(
                                                      child: Text(
                                                        'Отклик',
                                                        style: GoogleFonts.inter(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),

                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    const Text('Ваш комментарий'),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    Text(upperfirst(
                                                        item['comment'].toString())),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    const Text('Ваша цена'),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    Text(upperfirst(
                                                        "${item['price']}")),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    const Text('Дата и время начала'),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    Text(
                                                        item['date_time'].toString().substring(0,16)),
                                                    const SizedBox(
                                                      height: 12,
                                                    ),
                                                  ],
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    width: MediaQuery.of(context).size.width / 2 + 32,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Center(
                                                          child: Text(
                                                            'Закрыть',
                                                            style: GoogleFonts.inter(
                                                              color: Colors.white,
                                                              fontSize: 16,
                                                            ),
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                height: 52,
                                width: MediaQuery.of(context).size.width/2 -32,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text(
                                    'Смотреть отклик',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
