// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newlensfront/view/auth/registration/registration_freelancer_view/set_freelancer_send_on_you_view.dart';
import '../../../../main.dart';

final ImagePicker picker = ImagePicker();
Future<void> getImage() async {
  final XFile? image = await picker.pickImage(source: ImageSource.camera);
}

class SetFreelancerAddPhotoView extends StatelessWidget {
  String email;
  String password;
  String city;
  String name;
  String date_of_burn;
  SetFreelancerAddPhotoView(
      {super.key,
      required this.password,
      required this.email,
      required this.city,
      required this.date_of_burn,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child:
                            Image.asset('assets/design/images/arrowleft.png')),
                    Text(
                      'Шаг 1 из 3',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Image.asset('assets/design/images/cross.png'),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  translateController.Add_a_photo_to_your_profile,
                  style: GoogleFonts.inter(
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  translateController
                      .To_be_trusted_make_sure_you_use_a_good_quality_photo,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff808080),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 9.3,
                ),
                Center(child: Image.asset('assets/design/images/user.png')),
                const SizedBox(
                  height: 7,
                ),
                Center(
                    child: Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                )),
                const SizedBox(
                  height: 12,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.gallery);
                    },
                    child: Container(
                      height: 40,
                      width: 225,
                      decoration: BoxDecoration(
                        color: const Color(0xffEBEBEB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(translateController.Upload_a_photo),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: Text(
                    translateController.Photo_can_be_added_later,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff808080),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 45),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SetFreelancerSendOnYouView(
                      name: name,
                      password: password,
                      photo: '',
                      city: city,
                      email: email, date_of_burn: date_of_burn, categories: [],
                    )));
          },
          child: Container(
            height: 52,
            width: MediaQuery.of(context).size.width - 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color:  const  Color(0xffACC1B4),
            ),
            child: Center(
              child: Text(translateController.Continue,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
//