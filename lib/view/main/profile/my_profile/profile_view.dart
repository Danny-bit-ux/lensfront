import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newlensfront/view/main/profile/my_profile/service/my_services.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';
import '../../../../ServerRoutes.dart';
import '../../../../controller/edit_profile_controller.dart';
import '../../../../controller/order_controller.dart';
import '../../../../controller/services_controller.dart';
import '../../../../domain/user/auth/create_user.dart';
import '../../../../domain/user/get_user_profile.dart';
import '../../../auth/start_screen.dart';
import '../../../no_login/no_login_home.dart';
import '../other_profile/other_freelancer_profile_view.dart';
import 'edit_profile_view.dart';
class ProfileView extends GetView {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {

    final image =  NetworkImage('${ServerRoutes.host}/avatar?path=avatar_$uid');
    final userModel = context.watch<GetUserProfile>();
    final editModel = context.read<EditProfileController>();
    final serviceController = Get.put(ServicesController());
    final reviewsController = Get.put(OrderController());

    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      appBar: AppBar(
        title: const Text('Профиль'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: InkWell(
                onTap: () {
                  editModel.setParameters(
                      name: userModel.userModel!.name,
                      email: userModel.userModel!.email,
                      city: userModel.userModel!.city,
                      category: '',
                      dateOfBurn: userModel.userModel!.date_of_burn,
                      skills: userModel.userModel!.skills,
                      education: userModel.userModel!.education,
                      experience: userModel.userModel!.experience,
                      aboutMe: userModel.userModel!.about_me,
                      clientVisiting: userModel.userModel!.client_visiting);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditProfileView()));
                },
                child: const Icon(Icons.settings)),
          ),
        ],
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
                              backgroundImage: image,
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
                                userModel.userModel!.name,
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
                                  Text(
                                  userModel.userModel!.rating.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.star_rate_rounded,
                                    color: Colors.amber,
                                    size: 24,
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
                      userModel.userModel!.skills != 'null'
                          ? const Text(
                        'Навыки:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff333333),
                        ),
                      )
                          : const SizedBox(),
                      userModel.userModel!.skills != 'null'
                          ? Text(userModel.userModel!.skills)
                          : const SizedBox(),
                      const SizedBox(
                        height: 12,
                      ),
                      userModel.userModel!.education != 'null'
                          ? const Text(
                        'Образование:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff333333),
                        ),
                      )
                          : const SizedBox(),
                      userModel.userModel!.education != 'null'
                          ? Text(userModel.userModel!.education)
                          : const SizedBox(),
                      const SizedBox(
                        height: 12,
                      ),
                      userModel.userModel!.experience != 'null'
                          ? const Text(
                        'Опыт:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff333333),
                        ),
                      )
                          : const SizedBox(),
                      userModel.userModel!.experience != 'null'
                          ? Text(userModel.userModel!.experience)
                          : const SizedBox(),
                      const SizedBox(
                        height: 12,
                      ),
                      userModel.userModel!.about_me != 'null'
                          ? const Text(
                        'О себе:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff333333),
                        ),
                      )
                          : const SizedBox(),
                      userModel.userModel!.about_me != 'null'
                          ? Text(userModel.userModel!.about_me)
                          : const SizedBox(),
                      const SizedBox(
                        height: 12,
                      ),
                      userModel.userModel!.client_visiting != 'null'
                          ? const Text(
                        'Выезд к клиенту:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff333333),
                        ),
                      )
                          : const SizedBox(),
                      userModel.userModel!.client_visiting != 'null'
                          ? Text(userModel.userModel!.client_visiting)
                          : const SizedBox(),
                      const SizedBox(
                        height: 12,
                      ),
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
                              serviceController.myServicesShort.length >= 3
                                  ? 3
                                  : serviceController.myServicesShort.length,
                                  (index) {
                                final item =
                                serviceController.myServicesShort.value[index];
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
                                  builder: (context) =>  MyServices(my: true,id: uid,)));
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
                      color: const Color(0xffFAFAFA),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SingleChildScrollView(
                        child: Obx(
                              () => Column(
                            children: [
                              const SizedBox(height: 12,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 14.0),
                                    child: GestureDetector(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                        child: Image.asset('assets/design/images/cross.png')),
                                  ),
                                  Text('Отзывы',
                                    style: GoogleFonts.inter(
                                      color: const Color(0xff333333),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),),
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
                              const SizedBox(height: 12,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                    reviewsController.reviews.length, (index) {
                                  final item = reviewsController.reviews[index];
                                  int rating = int.parse(item['rating']);
                                  return ProfileReviewCard(rating: rating, item: item);
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
                            reviewsController.reviews.length.toString(),
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
                        reviewsController.reviews.isNotEmpty ? 1 : 0, (index) {
                      final item = reviewsController.reviews[index];
                      int rating = int.parse(item['rating']);
                      return ProfileReviewCard(rating: rating, item: item);
                    }),
                  ),
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              const DeleteProfileButton(),
              const SizedBox(
                height: 12,
              ),
              const ExitButton(),
            ],
          ),
        ),
      ),
    );
  }
}



class DeleteProfileButton extends StatelessWidget {
  const DeleteProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () async {
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
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xffEBEBEB),
            borderRadius: BorderRadius.circular(12),
          ),
          height: 52,
          width: MediaQuery.of(context).size.width - 40,
          child: const Center(
              child: Text(
                'Удалить профиль',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              )),
        ),
      ),
    );
  }
}


class ExitButton extends StatelessWidget {
  const ExitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: GestureDetector(
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
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xffEBEBEB),
            borderRadius: BorderRadius.circular(12),
          ),
          height: 52,
          width: MediaQuery.of(context).size.width - 40,
          child: const Center(
              child: Text(
                'Выйти',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              )),
        ),
      ),
    );
  }
}


class ProfileReviewCard extends StatelessWidget {
  final int rating;
  final item;
  const ProfileReviewCard({super.key, required this.rating, required this.item});

  @override
  Widget build(BuildContext context) {
    final image = NetworkImage('${ServerRoutes.host}/avatar?path=avatar_${item['sender_id']}');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
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
              GestureDetector(
                onTap: () async {
                  final userModel =Provider.of<GetUserProfile>(context, listen: false);
                  final user = await userModel.getOtherUserProfile(item['sender_id']);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> OtherFreelancerProfileView(thisUid:item['sender_id'] , userModel: user)));
                },
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0),
                            radius: 23,
                            backgroundImage: image,
                            // AssetImage('assets/dwd_logo.jpeg'),
                          ),
                        ),
                        const SizedBox(width: 4,),
                        Text(
                          item['sender_name'].toString(),
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
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
  }
}
