import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../ServerRoutes.dart';
import '../../controller/user_controller.dart';
import '../../domain/user/get_user_profile.dart';
import 'profile/other_profile/other_freelancer_profile_view.dart';

class NewMastersView extends GetView<UserController> {
  const NewMastersView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    controller.getNewMasters();
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
          ()=> ListView(
          children: List.generate(controller.newMasters.length, (index) {
            var item = controller.newMasters[index];
            final image = NetworkImage('${ServerRoutes.host}/avatar?path=avatar_${item['uid']}');
            return  GestureDetector(
              onTap: () async {
                final userModel =
                Provider.of<GetUserProfile>(context, listen: false);
                final user = await userModel.getOtherUserProfile(item['uid']);
                Navigator.push(context, MaterialPageRoute(builder: (context)=> OtherFreelancerProfileView(thisUid: item['uid'], userModel: user)));
              },
              child: Container(
                height: 88,
                width: MediaQuery.of(context).size.width-32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CircleAvatar(radius: 32,
                        backgroundImage: image,

                      ),
                      const SizedBox(width: 8,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(item['name'].toString(), style: const TextStyle(
                            fontSize: 18,fontWeight: FontWeight.bold,
                          ),),
                          Row(
                            children: [
                              Text(
                               item['rating'].toString(),
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xffF9CF3A)),
                              ),
                              SvgPicture.asset(
                                'assets/design/images/mini_star.svg',
                                color: const Color(0xffF9CF3A),
                                height: 24,
                                width: 24,
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
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
