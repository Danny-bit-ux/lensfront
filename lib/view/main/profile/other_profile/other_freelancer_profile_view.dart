import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';
import '../../../../ServerRoutes.dart';
import '../../../../controller/order_controller.dart';
import '../../../../controller/services_controller.dart';
import '../../../../data/chat_data_repository.dart';
import '../../../../domain/user/auth/create_user.dart';
import '../../../../domain/user/get_user_profile.dart';
import '../../../../model/other_user_model.dart';
import '../../../no_login/no_login_home.dart';
import '../../chat/chat_view.dart';
import '../my_profile/service/my_services.dart';

class OtherFreelancerProfileView extends GetView<GetUserProfile> {
  final thisUid;
  final OtherUserModel userModel;
  const OtherFreelancerProfileView(
      {super.key, required this.thisUid, required this.userModel});

  @override
  Widget build(BuildContext context) {
    final serviceController = Get.put(ServicesController());
    final reviewsController = Get.put(OrderController());
    reviewsController.getFreelancerReviews(userModel.uid);
    serviceController.getFreelancerServices(userModel.uid);
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      appBar: AppBar(
        title: const Text('Профиль'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(12),
                ),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0),
                              radius: 45,
                              backgroundImage: NetworkImage(
                                  '${ServerRoutes.host}/avatar?path=avatar_${userModel.uid}'),
                              // AssetImage('assets/dwd_logo.jpeg'),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userModel.name.toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                               Row(
                                children: [
                                  const Icon(
                                    Icons.star_rate_rounded,
                                    color: Colors.amber,
                                    size: 24,
                                  ),
                                  Text(
                                    userModel.rating.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        height: 1,
                        color: const Color(0xffCBCBCB),
                        width: MediaQuery.of(context).size.width - 40,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      userModel.skills.toString() != 'null'
                          ? const Text(
                              'Навыки:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff333333),
                              ),
                            )
                          : const SizedBox(),
                      userModel.skills.toString() != 'null'
                          ? Text(upperfirst(userModel.skills))
                          : const SizedBox(),
                      const SizedBox(
                        height: 12,
                      ),
                      userModel.education.toString() != 'null'
                          ? const Text(
                              'Образование:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff333333),
                              ),
                            )
                          : const SizedBox(),
                      userModel.education != 'null'
                          ? Text(upperfirst(userModel.education))
                          : const SizedBox(),
                      const SizedBox(
                        height: 12,
                      ),
                      userModel.experience != 'null'
                          ? const Text(
                              'Опыт:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff333333),
                              ),
                            )
                          : const SizedBox(),
                      userModel.experience != 'null'
                          ? Text(upperfirst(userModel.experience))
                          : const SizedBox(),
                      const SizedBox(
                        height: 12,
                      ),
                      userModel.aboutMe != 'null'
                          ? const Text(
                              'О себе:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff333333),
                              ),
                            )
                          : const SizedBox(),
                      userModel.aboutMe != 'null'
                          ? Text(upperfirst(userModel.aboutMe))
                          : const SizedBox(),
                      const SizedBox(
                        height: 12,
                      ),
                      userModel.clientVisiting != 'null'
                          ? const Text(
                              'Выезд к клиенту:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff333333),
                              ),
                            )
                          : const SizedBox(),
                      userModel.clientVisiting != 'null'
                          ? Text(upperfirst(userModel.clientVisiting))
                          : const SizedBox(),
                      const SizedBox(
                        height: 12,
                      ),
                   GestureDetector(
                     onTap: ()async{
                       final chatRepository =
                       Provider.of<ChatDataRepository>(context,
                           listen: false);
                       String id = await chatRepository.createChat(
                           '3', 'null', [uid,userModel.uid], userModel.uid);
                       Navigator.push(
                           context,
                           MaterialPageRoute(
                           builder: (context) => OpenChatView(
                         cid: id,
                         started: false,
                         chatModel: ChatModel(
                           model: '',
                           type: '0',
                           name: '',
                           chatId: id,
                           createdAt: '',
                           lastMessage: '',
                           lastMessageSender: '',
                           opponentAvatar: '',
                           opponentFirstName: '',
                           opponentLastName: '',
                           opponentNickName: '',
                         ),
                       )));
                     },
                     child: Container(
                       height: 52,
                       width: MediaQuery.of(context).size.width -32,
                       decoration: BoxDecoration(
                         color: Colors.red,
                         borderRadius: BorderRadius.circular(8),
                       ),
                       child: const Center(
                         child: Text('Написать',style: TextStyle(
                           color: Colors.white
                         ),),
                       ),
                     ),
                   ),
                   SizedBox(height: 12,),

                   serviceController.freelancerServices.isNotEmpty ?  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Услуги и цены:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff333333),
                            ),
                          ),
                          Obx(
                                () => Column(
                              children: List.generate(
                                  serviceController.freelancerServices.length >= 3
                                      ? 3
                                      : serviceController.freelancerServices.length,
                                      (index) {
                                    final item =
                                    serviceController.freelancerServices[index];
                                    return Padding(
                                      padding:
                                      const EdgeInsets.symmetric(vertical: 3.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            item['name'],
                                            style: GoogleFonts.inter(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text('${item['price_min']}€'),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ),

                      const SizedBox(
                        height: 12,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  MyServices(my: false,id: userModel.uid,)));
                        },
                        child: Container(
                          height: 33,
                          width: 223,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(46),
                              color: const Color(0xffEBEBEB)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Смотреть все услуги и цены',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              Image.asset('assets/design/images/arrowright.png')
                            ],
                          ),
                        ),
                      ),
                        ],
                   ) : const SizedBox(),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () {
                  Get.bottomSheet(Container(
                    height: 430,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                        topLeft: Radius.circular(12),
                      ),
                      color: Color(0xffFAFAFA),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SingleChildScrollView(
                        child: Obx(
                          () => Column(
                            children: [
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 14.0),
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Image.asset(
                                            'assets/design/images/cross.png')),
                                  ),
                                  Text(
                                    'Отзывы',
                                    style: GoogleFonts.inter(
                                      color: const Color(0xff333333),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.star_rate_rounded,
                                        color: Colors.amber,
                                        size: 24,
                                      ),
                                      Text(
                                        '4.9',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                    reviewsController.reviews.length, (index) {
                                  final item = reviewsController.reviews[index];
                                  int rating = int.parse(item['rating']);
                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 3),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  item['sender_name']
                                                      .toString(),
                                                  style: GoogleFonts.inter(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/design/images/mini_star.svg',
                                                    ),
                                                    SvgPicture.asset(
                                                      'assets/design/images/mini_star.svg',
                                                      color: rating > 1
                                                          ? const Color(
                                                              0xffF9CF3A)
                                                          : Colors.grey,
                                                    ),
                                                    SvgPicture.asset(
                                                      'assets/design/images/mini_star.svg',
                                                      color: rating > 2
                                                          ? const Color(
                                                              0xffF9CF3A)
                                                          : Colors.grey,
                                                    ),
                                                    SvgPicture.asset(
                                                      'assets/design/images/mini_star.svg',
                                                      color: rating > 3
                                                          ? const Color(
                                                              0xffF9CF3A)
                                                          : Colors.grey,
                                                    ),
                                                    SvgPicture.asset(
                                                      'assets/design/images/mini_star.svg',
                                                      color: rating > 4
                                                          ? const Color(
                                                              0xffF9CF3A)
                                                          : Colors.grey,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              item['timestamp']
                                                  .toString()
                                                  .substring(0, 10),
                                              style: GoogleFonts.inter(
                                                color: const Color(0xff808080),
                                                fontSize: 12,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              item['order_category'],
                                              style: GoogleFonts.inter(
                                                color: const Color(0xff808080),
                                                fontSize: 12,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              upperfirst(item['comment']),
                                              style: GoogleFonts.inter(
                                                fontSize: 12,
                                              ),
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
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Отзывы',
                        style: GoogleFonts.inter(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            reviewsController.freelancerReviews.length.toString(),
                            style: GoogleFonts.inter(
                              color: const Color(0xff808080),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                        reviewsController.freelancerReviews.isNotEmpty ? 1 : 0, (index) {
                      final item = reviewsController.freelancerReviews[index];
                      int rating = int.parse(item['rating']);
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item['sender_name'].toString(),
                                    style: GoogleFonts.inter(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Row(
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
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                item['timestamp'].toString().substring(0, 10),
                                style: GoogleFonts.inter(
                                  color: const Color(0xff808080),
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                item['order_category'],
                                style: GoogleFonts.inter(
                                  color: const Color(0xff808080),
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                upperfirst(item['comment']),
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
