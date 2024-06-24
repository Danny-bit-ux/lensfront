// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../controller/order_controller.dart';
import '../../../../domain/user/auth/create_user.dart';
import '../../../order/create_review_view.dart';
import '../../../widgets/order_card_widget.dart';
import '../../home_view.dart';
import 'my_order_info_view.dart';

class MyOrdersView extends GetView<OrderController> {
  const MyOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderController());
    controller.getMyActiveOrders(int.parse(uid));
    controller.getMyArchiveOrders(int.parse(uid));
    return Obx(
      () => Scaffold(
        backgroundColor: const Color(0xffFAFAFA),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child:
                            Image.asset('assets/design/images/arrowleft.png'),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Text(
                        'Мои заявки',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 13,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'Мои заявки',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff333333),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.setArchive(false);
                        },
                        child: Container(
                          height: 34,
                          width: MediaQuery.of(context).size.width / 2 - 24,
                          decoration: BoxDecoration(
                            color: controller.archive.value == false
                                ? Colors.red
                                : Colors.black,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              'Активные',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.setArchive(true);
                        },
                        child: Container(
                          height: 34,
                          width: MediaQuery.of(context).size.width / 2 - 24,
                          decoration: BoxDecoration(
                            color: controller.archive.value == true
                                ? Colors.red
                                : Colors.black,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              'Завершённые',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Column(
                    children: List.generate(
                        controller.archive.value == false
                            ? controller.myActiveOrders.value.length
                            : controller.myArchiveOrders.value.length, (index) {
                      final item = controller.archive.value == false
                          ? controller.myActiveOrders.value[index]
                          : controller.myArchiveOrders.value[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        child: controller.archive.value == false
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MyOrderInfoView(id: item.id,categoryName: item.category,)));
                                },
                                child: OrderCardWidget(
                                    item: item,
                                    myOrders: true,
                                    profileModel: null),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(14)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        upperfirst(item.name),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        item.dateAndTime,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                      item.remotely == '0' || item.remotely == 0
                                          ? Row(
                                              children: [
                                                const Icon(
                                                  Icons.near_me,
                                                  color: Colors.grey,
                                                  size: 12,
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  item.city,
                                                  style: GoogleFonts.inter(
                                                      color: Colors.grey,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            )
                                          : const Text('Удалённо'),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "${item.priceMin}-${item.priceMax}€",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      item.reviewCustomer == null ||
                                              item.reviewCustomer == 0 ||
                                              item.reviewCustomer == 'null'
                                          ? GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CreateReviewView(
                                                              freelancer: false,
                                                              recipientUid: item
                                                                  .freelancer,
                                                              pid: item.id,
                                                            )));
                                              },
                                              child: Container(
                                                height: 52,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    32,
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Оставить отзыв',
                                                    style: GoogleFonts.inter(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return MyOrdersAlert(
                                                            pid: item.id,
                                                          );
                                                        });
                                                  },
                                                  child: Container(
                                                    height: 52,
                                                    width:
                                                        MediaQuery.of(context)
                                                                    .size
                                                                    .width /
                                                                2 -
                                                            32,
                                                    decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        'Смотреть отзыв',
                                                        style:
                                                            GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontSize: 16,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 52,
                                                  width: MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          2 -
                                                      32,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'Смотреть отклик',
                                                      style: GoogleFonts.inter(
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontSize: 16,
                                                        color: Colors.white,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyOrdersAlert extends GetView<OrderController> {
  final dynamic pid;
  const MyOrdersAlert({super.key, required this.pid});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderController());
    int rating = 0;
    Future.delayed(const Duration(milliseconds: 10), () async {
      rating = await controller.getReviewFromOrderId(pid);
    });

    return Obx(
      () => AlertDialog(
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
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: Text(
                        'Ваш отзыв',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/design/images/mini_star.svg',
                        ),
                        SvgPicture.asset(
                          'assets/design/images/mini_star.svg',
                          color: rating > 1
                              ? const Color(0xffF9CF3A)
                              : Colors.grey,
                        ),
                        SvgPicture.asset(
                          'assets/design/images/mini_star.svg',
                          color: rating > 2
                              ? const Color(0xffF9CF3A)
                              : Colors.grey,
                        ),
                        SvgPicture.asset(
                          'assets/design/images/mini_star.svg',
                          color: rating > 3
                              ? const Color(0xffF9CF3A)
                              : Colors.grey,
                        ),
                        SvgPicture.asset(
                          'assets/design/images/mini_star.svg',
                          color: rating > 4
                              ? const Color(0xffF9CF3A)
                              : Colors.grey,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(upperfirst(
                        controller.orderReview['comment'].toString())),
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
      ),
    );
  }
}
