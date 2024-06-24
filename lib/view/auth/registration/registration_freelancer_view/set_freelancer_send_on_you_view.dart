// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../controller/send_for_user_controller.dart';
import '../../../../domain/user/auth/create_user.dart';
import '../../../../domain/user/get_user_profile.dart';
import '../../../../main.dart';
import 'edit_send_for_you_form_view.dart';
import 'set_freelancer_success.dart';
bool transit = false;
class SetFreelancerSendOnYouView extends StatefulWidget {
  String email;
  String password;
  String city;
  String name;
  String date_of_burn;
  var photo;
  List categories;
  SetFreelancerSendOnYouView(
      {super.key,
      required this.name,
      required this.password,
      required this.date_of_burn,
      required this.city,
      required this.email,
      required this.photo,
      required this.categories});

  @override
  State<SetFreelancerSendOnYouView> createState() => _SetFreelancerSendOnYouViewState();
}

class _SetFreelancerSendOnYouViewState extends State<SetFreelancerSendOnYouView> {
  @override
  Widget build(BuildContext context) {
    final infoModel = context.watch<SendForUserController>();
    final createUserModel = context.read<CreateUser>();
    final getUserDataModel = context.read<GetUserProfile>();
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
                      '2 из 3',
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
                  'Расскажите о себе',
                  style: GoogleFonts.inter(
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  translateController.Write_down_why_it_is_worth_choosing_you,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff808080),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SendForYouCard(
                  text: translateController.Skills,
                  id: 1,
                ),
                SendForYouCard(
                  text: translateController.Education,
                  id: 2,
                ),
                SendForYouCard(
                  text: translateController.Experience,
                  id: 3,
                ),
                SendForYouCard(
                  text: translateController.About_me,
                  id: 4,
                ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text('Выезд к клиенту'),
                   CupertinoSwitch(value: transit, onChanged: (v){
                     transit = v;
                     setState(() {

                     });
                   }),
                 ],
               ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2.73,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 45),
        child: GestureDetector(
          onTap: () async {
            int uid = await createUserModel.createUser(
                name: widget.name,
                email: widget.email,
                categories: widget.categories,
                age: null,
                freelancer: true,
                last_login: DateTime.now().toString(),
                password_hash: widget.password,
                city: widget.city,
                country: 'Russia',
                date_of_burn: widget.date_of_burn,
                avatar: null,
                spheres: null,
                skills: infoModel.skills,
                education: infoModel.education,
                experience: infoModel.experience,
                about_me: infoModel.about_me,
                client_visiting: transit == true ? 'Да' : 'Нет',
                servises: null,
                rating: 5,
                reviews: null,
                email_succes: true);
            getUserDataModel.getUserProfile(uid);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                    const SetFreelancerSuccess()));
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

class SendForYouCard extends StatelessWidget {
  final String text;
  final int id;
  const SendForYouCard({super.key, required this.text, required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditSendForYouFormView(
                      name: text,
                      nameView: text,
                      id: id,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0),
        ),
        width: MediaQuery.of(context).size.width -32,
        height: 52,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: const Color(0xff808080),
                  ),
                ),
                Image.asset('assets/design/images/arrowright.png'),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              height: 1,
              color: const Color(0xffEBEBEB),
              width: MediaQuery.of(context).size.width - 40,
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}

