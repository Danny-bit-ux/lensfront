import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../domain/user/auth/create_user.dart';
import '../../../../domain/user/get_user_profile.dart';
import '../../../../main.dart';
import '../../../main_view.dart';

class SetFreelancerSuccess extends StatelessWidget {
  const SetFreelancerSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 100), () {
      GetUserProfile().getUserProfile(uid);
    });
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

             Text(translateController.Congratulations_you_have_become_a_professional,style: GoogleFonts.inter(
              fontSize: 22,
            ), textAlign: TextAlign.center,),
            const SizedBox(height: 12,),
             Text(translateController.Now_you_can_fulfill_orders,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w400,
              color: const Color(0xff808080),
            ),),
            const SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GestureDetector(
                onTap: () {

                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MainView()), (route) => false);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width -40,
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color:  const  Color(0xffACC1B4),
                  ),
                  child:  Center(child: Text(translateController.Search_for_orders, style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: const Color(0xffFAFAFA),
                  ),),
                  ),
                ),
              ),
            ),
            // const SizedBox(height: 16,),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
            //   child: GestureDetector(
            //     onTap: () {
            //       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const ProfileView()), (route) => false);
            //     },
            //     child: Container(
            //       width: MediaQuery.of(context).size.width -40,
            //       height: 52,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(12),
            //         color: const Color(0xffEBEBEB),
            //       ),
            //       child:  Center(child: Text(translateController.View_the_profile, style: GoogleFonts.inter(
            //         fontWeight: FontWeight.w600,
            //         fontSize: 16,
            //         color: const Color(0xf3333333),
            //       ),),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
