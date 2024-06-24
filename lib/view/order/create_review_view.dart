import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';

import '../../controller/order_controller.dart';
import '../../domain/user/auth/create_user.dart';

TextEditingController _commentController = TextEditingController();
FocusNode _focusNode = FocusNode();

class CreateReviewView extends GetView<OrderController> {
  final String recipientUid;
  final String pid;
  final bool freelancer;
  const CreateReviewView(
      {super.key,
      required this.pid,
      required this.recipientUid,
      required this.freelancer});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderController());
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xffFAFAFA),
        appBar: AppBar(
          title: const Text('Оставить отзыв'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 12,
              ),
              Center(
                child: Text(
                  'Спасибо за выполнение\nзаказа!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Center(
                child: Text(
                  'Вы можете оставить отзыв о заказчике',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          controller.selectRating(1);
                        },
                        child: SvgPicture.asset(
                          'assets/design/images/big_star.svg',
                          color: controller.rating.value > 0
                              ? const Color(0xffF9CF3A)
                              : Colors.grey,
                        )),
                    GestureDetector(
                        onTap: () {
                          controller.selectRating(2);
                        },
                        child: SvgPicture.asset(
                          'assets/design/images/big_star.svg',
                          color: controller.rating.value > 1
                              ? const Color(0xffF9CF3A)
                              : Colors.grey,
                        )),
                    GestureDetector(
                        onTap: () {
                          controller.selectRating(3);
                        },
                        child: SvgPicture.asset(
                          'assets/design/images/big_star.svg',
                          color: controller.rating.value > 2
                              ? const Color(0xffF9CF3A)
                              : Colors.grey,
                        )),
                    GestureDetector(
                        onTap: () {
                          controller.selectRating(4);
                        },
                        child: SvgPicture.asset(
                          'assets/design/images/big_star.svg',
                          color: controller.rating.value > 3
                              ? const Color(0xffF9CF3A)
                              : Colors.grey,
                        )),
                    GestureDetector(
                        onTap: () {
                          controller.selectRating(5);
                        },
                        child: SvgPicture.asset(
                          'assets/design/images/big_star.svg',
                          color: controller.rating.value > 4
                              ? const Color(0xffF9CF3A)
                              : Colors.grey,
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                focusNode: _focusNode,
                maxLines: 10,
                minLines: 5,
                maxLength: 1000,
                controller: _commentController,
                decoration: InputDecoration(
                  hintStyle: const TextStyle(
                    color: Color(
                      0xFFCBCBCB,
                    ),
                  ),
                  hintText: 'Напишите свои впечатления о работе с заказчиком',
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
          child: GestureDetector(
            onTap: () async {
              freelancer == true
                  ? await controller.createReviewFreelancer(
                      uid: recipientUid,
                      senderUid: uid,
                      pid: pid,
                      comment: _commentController.text,
                      rating: controller.rating.value.toString())
                  : await controller.createReviewCustomer(
                      uid: recipientUid,
                      senderUid: uid,
                      pid: pid,
                      comment: _commentController.text,
                      rating: controller.rating.value.toString());
              freelancer == true
                  ? controller.getCompleteOrders()
                  : controller.getMyArchiveOrders(uid);
              Navigator.pop(context);
            },
            child: Container(
              height: 52,
              width: MediaQuery.of(context).size.width - 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.red,
              ),
              child: Center(
                child: Text(
                  'Оставить отзыв',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
