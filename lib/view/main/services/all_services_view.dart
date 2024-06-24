import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../../ServerRoutes.dart';
import '../../../controller/services_controller.dart';
import '../../../domain/user/get_user_profile.dart';
import '../profile/other_profile/other_freelancer_profile_view.dart';
import 'open_service_view.dart';
class AllServicesView extends GetView<ServicesController> {
  const AllServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ServicesController());
    controller.getAllServices('');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Последние услуги'),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xffFAFAFA),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Obx(
          () => ListView(
            children: List.generate(controller.allServices.length, (index) {
              final item = controller.allServices[index];
              return NewServiceCardWidget(
                item: item,
                order: false,
              );
            }),
          ),
        ),
      ),
    );
  }
}

class NewServiceCardWidget extends StatelessWidget {
  final item;
  final bool order;
  const NewServiceCardWidget(
      {super.key, required this.item, required this.order});

  @override
  Widget build(BuildContext context) {
    final image =
        NetworkImage('${ServerRoutes.host}/avatar?path=avatar_${item['uid']}');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        width: MediaQuery.of(context).size.width - 32,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async {
                  final userModel =
                      Provider.of<GetUserProfile>(context, listen: false);
                  final user = await userModel.getOtherUserProfile(item['uid']);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OtherFreelancerProfileView(
                              thisUid: item['uid'], userModel: user)));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 30,
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
                              item['name'],
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff808080),
                              ),
                            ),
                            Text(
                              item['freelancer_name'].toString(),
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: const Color(0xff4B4B4B),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  item['freelancer_rating'].toString(),
                                  style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xffF9CF3A)),
                                ),
                                SvgPicture.asset(
                                  'assets/design/images/mini_star.svg',
                                  color: const Color(0xffF9CF3A),
                                ),
                                Text(
                                  getReviewsString(
                                      int.parse(item['reviews'].toString())),
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
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item['fixPrice'] == '0' && item['hourPrice'] == '1'
                        ? 'От ${item['price_min']}€ в час'
                        : item['fixPrice'] == '0'
                            ? 'От ${item['price_min']}€'
                            : item['hourPrice'] == '1'
                                ? '${item['price_min']}€ в час'
                                : '${item['price_min']}€',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OpenServiceView(item: item,)));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffF14F44),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Записаться',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xffFAFAFA),
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
  }
}

String getReviewsString(int count) {
  if (count % 10 == 1 && count % 100 != 11) {
    return '$count отзыв';
  } else if (count % 10 >= 2 &&
      count % 10 <= 4 &&
      (count % 100 < 10 || count % 100 >= 20)) {
    return '$count отзыва';
  } else {
    return '$count отзывов';
  }
}
