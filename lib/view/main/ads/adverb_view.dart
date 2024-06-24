// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../ServerRoutes.dart';
import '../../../controller/chat_controller.dart';
import '../../../data/chat_data_repository.dart';
import '../../../domain/user/auth/create_user.dart';
import '../../../model/ads_model.dart';
import '../../no_login/no_login_alert.dart';
import '../../no_login/no_login_services.dart';
import '../../view_model/visual/adv_visual_car_model.dart';
import '../chat/chat_view.dart';

class AdverbView extends StatelessWidget {
  final bool auth;
  final AdverbModel adverbModel;
  const AdverbView({super.key, required this.adverbModel, required this.auth});

  @override
  Widget build(BuildContext context) {
    final chatModel = Get.put(ChatController());
    final image = NetworkImage(
        '${ServerRoutes.host}/avatar?path=avatar_${adverbModel.uid}');
    final images = List.generate(
        adverbModel.images ?? 0,
        (index) => NetworkImage(
            '${ServerRoutes.host}/get_photo?path=${adverbModel.ccid}&ind=${index + 1}'));
    return Scaffold(
      appBar: AppBar(
        title: Text(adverbModel.age),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                height: 260,
                width: MediaQuery.of(context).size.width,
                child: PageView(
                  children: List.generate(
                      adverbModel.images ?? 0,
                      (index) => Container(
                            height: 260,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              image: DecorationImage(
                                  image: images[index], fit: BoxFit.fitWidth),
                            ),
                          )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Продажа',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff6FC727),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '10',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                  color: const Color(0xffCBCBCB)),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Image.asset('assets/design/images/eye.png'),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      adverbModel.age.toString(),
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff333333),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      '${adverbModel.price}€',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                        color: const Color(0xff333333),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: image,
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              adverbModel.userName,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            Row(
                              children: [
                                Text(
                                  adverbModel.userRating,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Color(0xffF9CF3A),
                                  ),
                                ),
                                Image.asset('assets/design/images/fi_star.png'),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  getReviewsString(adverbModel.userReviews),
                                  // .toString(),
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff808080)),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    (adverbModel.phone == '1' && adverbModel.messages == '1')
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  auth == false
                                      ? showDialog<void>(
                                          useSafeArea: false,
                                          context: context,
                                          barrierDismissible:
                                              true, // user must tap button!
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor:
                                                  const Color(0xff2D2D2D)
                                                      .withOpacity(0),
                                              contentPadding: EdgeInsets.zero,
                                              insetPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12),
                                              content: const NoLoginAlert(),
                                            );
                                          })
                                      : null;
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      24,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: const Color(0xf3333333),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Позвонить',
                                    style:
                                        GoogleFonts.inter(color: Colors.white),
                                  )),
                                ),
                              ),
                              const SizedBox(
                                width: 7.8,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (auth == true) {
                                    print(adverbModel.id);
                                    final chatRepository =
                                        Provider.of<ChatDataRepository>(context,
                                            listen: false);
                                    String id = await chatRepository.createChat(
                                        '0', 'null', [uid, adverbModel.uid], adverbModel.id);
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
                                              )),
                                    );
                                  } else {
                                    showDialog<void>(
                                        useSafeArea: false,
                                        context: context,
                                        barrierDismissible:
                                            true, // user must tap button!
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor:
                                                const Color(0xff2D2D2D)
                                                    .withOpacity(0),
                                            contentPadding: EdgeInsets.zero,
                                            insetPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 12),
                                            content: const NoLoginAlert(),
                                          );
                                        });
                                  }
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      24,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: const Color(0xffF14F44),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Написать',
                                    style:
                                        GoogleFonts.inter(color: Colors.white),
                                  )),
                                ),
                              )
                            ],
                          )
                        : (adverbModel.messages == '1')
                            ? GestureDetector(
                                onTap: () async {
                                  if (auth == true) {
                                    print(adverbModel.id);
                                    final chatRepository =
                                        Provider.of<ChatDataRepository>(context,
                                            listen: false);
                                    String id = await chatRepository.createChat(
                                        '0', 'null', [uid, adverbModel.uid],adverbModel.id);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => OpenChatView(
                                                cid: id,
                                                started: false,
                                                chatModel: ChatModel(
                                                  name: '',
                                                  type: '0',
                                                  model: {},
                                                  chatId: id,
                                                  createdAt: '',
                                                  lastMessage: '',
                                                  lastMessageSender: '',
                                                  opponentAvatar: '',
                                                  opponentFirstName: '',
                                                  opponentLastName: '',
                                                  opponentNickName: '',
                                                ),
                                              )),
                                    );
                                  } else {
                                    showDialog<void>(
                                        useSafeArea: false,
                                        context: context,
                                        barrierDismissible:
                                            true, // user must tap button!
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor:
                                                const Color(0xff2D2D2D)
                                                    .withOpacity(0),
                                            contentPadding: EdgeInsets.zero,
                                            insetPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 12),
                                            content: const NoLoginAlert(),
                                          );
                                        });
                                  }
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 48,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: const Color(0xffF14F44),
                                  ),
                                  child: const Center(
                                      child: Text(
                                    'Написать',
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              )
                            : (adverbModel.phone == '1')
                                ? Container(
                                    width:
                                        MediaQuery.of(context).size.width - 48,
                                    height: 52,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: const Color(0xffF14F44),
                                    ),
                                    child: Center(
                                        child: Text(
                                      'Позвонить',
                                      style: GoogleFonts.inter(
                                          color: Colors.white),
                                    )),
                                  )
                                : const SizedBox(),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Описание',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: const Color(0xff808080)),
                    ),
                    Text(adverbModel.description.toString()),
                    const SizedBox(
                      height: 16,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Создано ${adverbModel.timestamp.toString().substring(0, 10)} в ${adverbModel.timestamp.toString().substring(11, 16)}',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff808080),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Категория "${adverbModel.category}"',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff808080),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
