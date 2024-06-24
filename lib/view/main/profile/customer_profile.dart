// ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables, must_be_immutable, depend_on_referenced_packages
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../../ServerRoutes.dart';
import '../../../controller/order_controller.dart';
import '../../../controller/user_controller.dart';
import '../../../domain/user/auth/create_user.dart';
import '../../../domain/user/get_user_profile.dart';
import '../../auth/registration/registration_freelancer_view/set_freelancer_success.dart';
import '../../auth/start_screen.dart';
import '../home_view.dart';

class CustomerProfileView extends GetView<GetUserProfile> {
  const CustomerProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(GetUserProfile());
    controller.getUserProfile(uid);
    final reviewsController = Get.put(OrderController());
    reviewsController.getReviews();
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffFAFAFA),
          title: const Text(
            'Профиль',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: const Color(0xffFAFAFA),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 24,
                ),
                Stack(
                  children: [
                    const Center(
                      child: CircleAvatar(
                        radius: 45,
                        backgroundImage: AssetImage('assets/dwd_logo.jpeg'),
                        // AssetImage('assets/dwd_logo.jpeg'),
                      ),
                    ),
                    Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0),
                        radius: 45,
                        backgroundImage: NetworkImage(
                            '${ServerRoutes.host}/avatar?path=avatar_$uid'),
                        // AssetImage('assets/dwd_logo.jpeg'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: Text(
                    controller.userModel!.name ?? '',
                    //  user.userModel!.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16), //333
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Настройки',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog<void>(
                              useSafeArea: false,
                              context: context,
                              barrierDismissible:
                                  false, // user must tap button!
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor:
                                      const Color(0xff2D2D2D).withOpacity(0),
                                  contentPadding: EdgeInsets.zero,
                                  insetPadding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  content: Container(
                                      height: 238,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: const Color(0xff2D2D2D)
                                            .withOpacity(0.9),
                                      ),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 24,
                                          ),
                                          Center(
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.87),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Center(
                                            child: Container(
                                              height: 1,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  64,
                                              color: const Color(0xff979797),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 24,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0),
                                            child: TextField(
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                              //     controller: _nameController,
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor:
                                                    const Color(0xff1D1D1D),
                                                hintStyle: const TextStyle(
                                                  color: Color(
                                                    0xff535353,
                                                  ),
                                                ),
                                                hintText: 'Your name',
                                                isDense: true,
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Color(0xff7A7A7A),
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    12,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    12,
                                                  ),
                                                  borderSide: const BorderSide(
                                                      color: Color(0xff7A7A7A),
                                                      width: 1),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 24,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: SizedBox(
                                                    height: 52,
                                                    width:
                                                        MediaQuery.of(context)
                                                                    .size
                                                                    .width /
                                                                2 -
                                                            52,
                                                    child: const Center(
                                                      child: Text(
                                                        'Cancel',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16,
                                                          color:
                                                              Color(0xff8875FF),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    // controller.changeName(
                                                    //     userModel!.uid,
                                                    //     _nameController.text);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    height: 52,
                                                    width:
                                                        MediaQuery.of(context)
                                                                    .size
                                                                    .width /
                                                                2 -
                                                            52,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      color: const Color(
                                                          0xff8875FF),
                                                    ),
                                                    child: const Center(
                                                      child: Text(
                                                        'Save',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )),
                                );
                              });
                        },
                        child: IconAndTextWidget(
                          icon: 'assets/svg/change_name.svg',
                          text: 'Изменить имя',
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      GestureDetector(
                        onTap: () {
                          //      Get.bottomSheet(Container());
                        },
                        child: GestureDetector(
                          onTap: () {
                            _main();
                          },
                          child: IconAndTextWidget(
                            icon: 'assets/svg/change_photo.svg',
                            text: 'Изменить фото',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.bottomSheet(Container(
                            height: 230,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color(0xff363636).withOpacity(0.8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 24,
                                ),
                                const Center(
                                  child: Text(
                                    'Change app Language',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Center(
                                  child: Container(
                                    height: 1,
                                    width:
                                        MediaQuery.of(context).size.width - 48,
                                    color: const Color(0xff7A7A7A),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                TextButton(
                                    onPressed: () {
                                      //   controller.changeLaunguage(ruModel);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Russian')),
                                TextButton(
                                    onPressed: () {
                                      //  controller.changeLaunguage(engModel);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('English')),
                              ],
                            ),
                          ));
                        },
                        child: IconAndTextWidget(
                          icon: 'assets/svg/change_language.svg',
                          text: 'Сменить язык',
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      IconAndTextWidget(
                        icon: 'assets/svg/delete_account.svg.svg',
                        text: 'Удалить аккаунт',
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      GestureDetector(
                        onTap: ()async {
                          uid = null;
                          FlutterSecureStorage flutterSecureStorage =
                          const FlutterSecureStorage();
                          await flutterSecureStorage.delete(key: 'uid');
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const StartView()),
                                  (route) => false);
                        },
                        child: IconAndTextWidget(
                          icon: 'assets/svg/meneger_logout.svg',
                          text: 'Выйти',
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      GestureDetector(
                        onTap: () {
                          UserController().setFreelancer();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SetFreelancerSuccess()));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 32,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.red)),
                          child: const Center(
                            child: Text(
                              "Стать специалистом",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                InkWell(
                  onTap: () {
                    Get.bottomSheet(
                      Container(
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
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 14.0),
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
                                      reviewsController.reviews.length,
                                      (index) {
                                    final item =
                                        reviewsController.reviews[index];
                                    int rating = int.parse(item['rating']);
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 3),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                                                      fontWeight:
                                                          FontWeight.w700,
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
                                                  color:
                                                      const Color(0xff808080),
                                                  fontSize: 12,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                item['order_category'],
                                                style: GoogleFonts.inter(
                                                  color:
                                                      const Color(0xff808080),
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
                    );
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
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            reviewsController.reviews.length.toString(),
                            style: GoogleFonts.inter(
                              color: const Color(0xff808080),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                        reviewsController.reviews.isNotEmpty ? 1 : 0, (index) {
                      final item = reviewsController.reviews[index];
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IconAndTextWidget extends StatelessWidget {
  final icon;
  final text;
  Color? color;
  IconAndTextWidget(
      {super.key, required this.icon, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          height: 24,
          width: 24,
          color: Colors.black,
        ),
        const SizedBox(
          width: 16,
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

Future<void> uploadImage(File imageFile) async {
  var url = Uri.parse('${ServerRoutes.host}/add_avatar');

  List<int> imageBytes = imageFile.readAsBytesSync();
  String base64Image = base64Encode(imageBytes);

  var requestBody = jsonEncode({
    'image': {'data': base64Image, 'name': 'avatar_$uid.jpg'}
  });

  await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: requestBody,
  );
}

void _main() async {
  final imagePicker = ImagePicker();
  final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery, imageQuality: 13);

  if (pickedFile != null) {
    File imageFile = File(pickedFile.path);

    await uploadImage(imageFile);
  }
}
