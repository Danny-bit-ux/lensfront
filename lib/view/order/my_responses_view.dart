import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/order_controller.dart';
import '../../domain/user/auth/create_user.dart';
import '../main/home_view.dart';

class MyResponsesView extends GetView<OrderController> {
  const MyResponsesView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderController());
    controller.getMyResponses(uid);
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      appBar: AppBar(
        title: const Text('Мои отклики'),
        centerTitle: true,
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: List.generate(controller.myResponses.length, (index) {
              final item = controller.myResponses[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.533),
                child: Container(
                  width: MediaQuery.of(context).size.width,
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
                          item['order_price_fix'] == '1'
                              ? "${item.priceMin}€"
                              : item['order_price_no'] == '1'
                              ? 'Договорная'
                              : "${item.priceMin}-${item.priceMax}€",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(item['order_date_and_time']),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Дата: ${item['date_time']}'),
                        Text('Ваша цена: ${item['price']}'),
                        Text('Ваш комментарий: ${item['comment']}'),
                        const SizedBox(
                          height: 8,
                        ),

                        const SizedBox(width: 12,),
                        GestureDetector(
                          onTap: () {
                            showDialog<void>(
                              context: context,
                              barrierDismissible:
                                  false, // user must tap button!
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    'Подтвердите действие',
                                    textAlign: TextAlign.center,
                                  ),
                                  content: const SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text(
                                          'Вы уверены что хотите отозвать отклик?',
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3 -
                                                10,
                                            height: 32,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Colors.black,
                                            ),
                                            child: const Center(
                                              child: Text(
                                                'Нет',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            controller
                                                .deleteMyResponse(item['id']);
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3 -
                                                10,
                                            height: 32,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Colors.red,
                                            ),
                                            child: const Center(
                                              child: Text(
                                                'Да',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 30,
                            width: MediaQuery.of(context).size.width  - 32,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                                child: Text(
                              'Отозвать',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            )),
                          ),
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
