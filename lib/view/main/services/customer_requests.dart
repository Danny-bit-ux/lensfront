// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../ServerRoutes.dart';
import '../../../controller/chat_controller.dart';
import '../../../controller/services_controller.dart';
import '../../../domain/user/auth/create_user.dart';
import '../../../domain/user/get_user_profile.dart';
import '../profile/other_profile/other_freelancer_profile_view.dart';

class CustomerRequestView extends GetView<ServicesController> {
  const CustomerRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ServicesController());
    controller.getCustomerBooking();
    return Obx(
          ()=>Scaffold(
        backgroundColor: const Color(0xffFAFAFA),
        appBar: AppBar(
          backgroundColor: const Color(0xffFAFAFA),
          centerTitle: true,
          title: const Text('Записи'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: controller.customerBooking.isNotEmpty ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                List.generate(controller.customerBooking.length, (index) {
                  final item = controller.customerBooking[index];
                  final image = NetworkImage(
                      '${ServerRoutes.host}/avatar?path=avatar_${item['customer_id']}');
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item['service_name'],
                                  style: GoogleFonts.inter(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  item['status'].toString(),
                                  style: GoogleFonts.inter(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              item['service_category'].toString(),
                              style: GoogleFonts.inter(
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4,),
                            Text('Желаемая дата: ${item['date'].toString().substring(0,10)}'),
                            const SizedBox(height: 4,),
                            Text(
                              'Описание: ${item['description']}',

                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            GestureDetector(
                              onTap: () async {
                                final userModel = Provider.of<GetUserProfile>(context,
                                    listen: false);
                                final user =
                                await userModel.getOtherUserProfile(item['uid']);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OtherFreelancerProfileView(
                                                thisUid: item['uid'],
                                                userModel: user)));
                              },
                              child: Container(
                                height: 88,
                                width: MediaQuery.of(context).size.width - 32,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                          radius: 32, backgroundImage: image),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            item['customer_name'].toString(),
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    item['customer_rating'].toString(),
                                                    style: GoogleFonts.inter(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w700,
                                                        color:
                                                        const Color(0xffF9CF3A)),
                                                  ),
                                                  SvgPicture.asset(
                                                    'assets/design/images/mini_star.svg',
                                                    color: const Color(0xffF9CF3A),
                                                    height: 24,
                                                    width: 24,
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                ],
                                              ),
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
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: ()async{   final chatModel = Get.put(ChatController());
                                  int cid = await chatModel.createChat(
                                      type: '3',
                                      uid1: uid,
                                      uid2: item['customer_id'],
                                      pid: item['id']);
                                  },
                                  child: Container(
                                    height: 32,
                                    width: MediaQuery.of(context).size.width / 2 -32,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.black,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Чат',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 32,
                                  width: MediaQuery.of(context).size.width / 2 -32,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.red,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Отменить',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
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
                }),
              ),
            ) : const Center(
              child: Text('У вас пока нет записей 😞', style: TextStyle(
                fontSize: 24,
              ),),
            ),
          ),
        ),
      ),
    );
  }
}
