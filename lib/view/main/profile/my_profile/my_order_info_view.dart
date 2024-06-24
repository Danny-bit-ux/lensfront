// ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newlensfront/view/main/profile/my_profile/service/my_services.dart';
import 'package:provider/provider.dart';
import '../../../../ServerRoutes.dart';
import '../../../../controller/chat_controller.dart';
import '../../../../controller/order_controller.dart';
import '../../../../domain/order/accept_response_order_domain.dart';
import '../../../../domain/user/auth/create_user.dart';
import '../../../../domain/user/get_user_profile.dart';
import '../../../../main.dart';
import '../../../../model/response_from_order_model.dart';
import '../other_profile/other_freelancer_profile_view.dart';

class MyOrderInfoView extends GetView<OrderController> {
  final id;
  final categoryName;
  const MyOrderInfoView(
      {super.key, required this.id, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderController());
    controller.getOrderInfo(id);
    controller.getServicesByOrder(categoryName);
    final freelancerModel = context.read<GetUserProfile>();
    var users;
    Future.delayed(const Duration(milliseconds: 1), () async {
      users = List.generate(0, (index) async {
        var user = await freelancerModel
            .getOtherUserProfile(controller.order.value.responses[index].uid);
        return {
          'name': user.name,
          'uid': controller.order.value.responses[index].uid,
          'rating': user.rating,
        };
      });
    });
    return Obx(
      () => Scaffold(
        backgroundColor: const Color(0xffFAFAFA),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                      Text(
                        'Моя заявка',
                        style: GoogleFonts.inter(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.order.value.orderStatus,
                        style: GoogleFonts.inter(),
                      ),
                      Row(
                        children: [
                          Text(
                            '${controller.order.value.sees}',
                            style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffCBCBCB)),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Image.asset('assets/design/images/eye.png'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    controller.order.value.name,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 54,
                      decoration: BoxDecoration(
                          color: const Color(0xffEBEBEB),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: const Color(0xffEBEBEB), width: 3)),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.changeToResponses();

                            },
                            child: Container(
                              height: 44,
                              width: MediaQuery.of(context).size.width / 2 - 28,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color:        controller.service.value == false ? const Color(0xffffffff) :const Color(0xffEBEBEB),
                              ),
                              child: Center(
                                child: Text(
                                  'Отклики',
                                  style: GoogleFonts.inter(),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.changeToServices();
                            },
                            child: Container(
                              height: 44,
                              width: MediaQuery.of(context).size.width / 2 - 28,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color:        controller.service.value == true ? const Color(0xffffffff) :const Color(0xffEBEBEB),
                              ),
                              child: Center(
                                child: Text(
                                  'Специалисты',
                                  style: GoogleFonts.inter(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  controller.service.value == false
                      ? controller.order.value.responses.isEmpty
                          ? const NoResponsesWidget()
                          : SingleChildScrollView(
                              child: Column(
                              children: List.generate(
                                  controller.order.value.responses.length,
                                  (index) {
                                final ResponseFromOrderModel item =
                                    controller.order.value.responses[index];
                                return ResponseCardWidget(
                                  item: item,
                                  index: index,
                                );
                              }),
                            ))
                      : Column(
                          children: List.generate(
                              controller.servicesFromOrder.length,
                              (index) => ServiceCardWidget(
                                    item: controller.servicesFromOrder[index],
                                    order: true,
                                my: false,
                                archive: false,
                                  )),
                        ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: MyOrderInfoBottomBar(
          id: id,
        ),
      ),
    );
  }
}

class MyOrderInfoBottomBar extends GetView<OrderController> {
  final id;
  const MyOrderInfoBottomBar({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderController());
    return Padding(
      padding: const EdgeInsets.only(bottom: 45.0, left: 20,right: 20),
      child: GestureDetector(
        onTap: controller.order.value.freelancer != 'null' &&
                controller.order.value.freelancer != null
            ? () {
                showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return CustomAlert(
                        title: 'Вы уверены что подтвердить исполнение заказа?',
                        onTap: {
                          controller
                              .orderContinueCustomer(controller.order.value.id),
                          controller.getOrderInfo(id)
                        },
                      );
                    });
              }
            : () {
                showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return CustomAlert(
                        title: 'Вы уверены что хотите закрыть заказ?',
                        onTap: {
                          controller.deleteOrder(controller.order.value.id),
                          controller.getOrderInfo(id)
                        },
                      );
                    });
              },
        child: Container(
          height: 57,
          width: MediaQuery.of(context).size.width - 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.red,
          ),
          child: Center(
              child: Text(
            controller.order.value.freelancer != 'null' &&
                    controller.order.value.freelancer != null
                ? 'Подтвердить исполнение'
                : 'Закрыть заявку',
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
          )),
        ),
      ),
    );
  }
}

class CustomAlert extends StatelessWidget {
  final String title;
  final onTap;
  const CustomAlert({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text(
          'Подтвердите действие',
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                title,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Row(children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 3 - 10,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black,
                ),
                child: const Center(
                  child: Text(
                    'Нет',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            InkWell(
              onTap: () {
                onTap;
                Navigator.of(context).pop();
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 3 - 10,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.red,
                ),
                child: const Center(
                  child: Text(
                    'Да',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          ])
        ]);
  }
}

class NoResponsesWidget extends StatelessWidget {
  const NoResponsesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(top: 130.0),
        child: Column(
          children: [
            Center(child: Image.asset('assets/design/images/Chat.png')),
            const SizedBox(
              height: 22,
            ),
            Text(
              'Подождите откликов от специалистов',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Или напишите им сами',
                  style: GoogleFonts.inter(
                    color: const Color(0xff808080),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ResponseButtonRowWidget extends GetView<OrderController> {
  final index;
  final id;
  const ResponseButtonRowWidget(
      {super.key, required this.index, required this.id});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            acceptResponseOrder(
                uid: controller.order.value.responses[index].uid,
                pid: controller.order.value.id);
            Future.delayed(const Duration(milliseconds: 100), () {
              controller.getOrderInfo(id);
            });
          },
          child: Container(
            height: 43,
            width: MediaQuery.of(context).size.width / 2 - 43,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
                child: Text(
              'Принять',
              style: GoogleFonts.inter(color: Colors.white, fontSize: 18),
            )),
          ),
        ),
        GestureDetector(
          onTap: ()async{   final chatModel = Get.put(ChatController());
            int cid = await chatModel.createChat(
                type: '0',
                uid1: uid,
                uid2: controller.order.value.responses[index].uid,
                pid: id);
            // Navigator.push(context, MaterialPageRoute(
            //     builder: (context) =>
            //         (cid: cid.toString(),
            //           subjectName: controller.order.value.name
            //               .toString(),)));
          },
          child: Container(
            height: 43,
            width: MediaQuery.of(context).size.width / 2 - 43,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
                child: Text(
              translateController.Chat,
              style: GoogleFonts.inter(color: Colors.white, fontSize: 18),
            )),
          ),
        )
      ],
    );
  }
}

class ResponseCardWidget extends GetView<OrderController> {
  final ResponseFromOrderModel item;
  final int index;
  const ResponseCardWidget({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderController());
    final image =
        NetworkImage('${ServerRoutes.host}/avatar?path=avatar_${item.uid}');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xffffffff),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              controller.order.value.freelancer == item.uid ?const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Исполнитель выбран!',
                                      style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: Colors.green,
                                      ),),
                    ),
                  ) : const SizedBox(),
              GestureDetector(
                onTap: () async {
                  final userModel =
                      Provider.of<GetUserProfile>(context, listen: false);
                  final user = await userModel.getOtherUserProfile(item.uid);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OtherFreelancerProfileView(
                              thisUid: item.uid, userModel: user)));
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundImage: image,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          item.freelancerName.toString(),
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: const Color(0xff4B4B4B),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '5.0',
                              style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xffF9CF3A)),
                            ),
                            SvgPicture.asset(
                              'assets/design/images/mini_star.svg',
                              color: const Color(0xffF9CF3A),
                              height: 12,
                              width: 12,
                            ),
                            SvgPicture.asset(
                              'assets/design/images/mini_star.svg',
                              color: const Color(0xffF9CF3A),
                              height: 12,
                              width: 12,
                            ),
                            SvgPicture.asset(
                              'assets/design/images/mini_star.svg',
                              color: const Color(0xffF9CF3A),
                              height: 12,
                              width: 12,
                            ),
                            SvgPicture.asset(
                              'assets/design/images/mini_star.svg',
                              color: const Color(0xffF9CF3A),
                              height: 12,
                              width: 12,
                            ),
                            SvgPicture.asset(
                              'assets/design/images/mini_star.svg',
                              color: const Color(0xffF9CF3A),
                              height: 12,
                              width: 12,
                            ),
                            const SizedBox(width: 4,),
                            Text(
                              '5 отзывов',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: const Color(0xff808080),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Предложеная цена:',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff333333),
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              item.price.toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff333333),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Дата начала работ:',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff333333),
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              item.date_and_time.toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff333333),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              controller.order.value.freelancer != 'null' &&
                      controller.order.value.freelancer != null
                  ? const SizedBox()
                  : ResponseButtonRowWidget(
                      id: item.id,
                      index: index,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
