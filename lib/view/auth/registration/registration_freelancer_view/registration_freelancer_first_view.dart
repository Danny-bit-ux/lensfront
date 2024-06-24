import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newlensfront/view/auth/registration/registration_freelancer_view/setFreelancer_1_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../main.dart';
import '../../../widgets/custom_textfield_widget.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class RegistrationFreelancerFirstView extends StatelessWidget {
  const RegistrationFreelancerFirstView({super.key});

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
                        child: Image.asset('assets/design/images/cross.png')),
                    Text(
                      translateController.Register,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  translateController.Please_enter_your_details,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500, fontSize: 22),
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextFieldWidget(
                    controller: emailController,
                    text: translateController.Enter_an_email,
                    password: false),
                const SizedBox(
                  height: 16,
                ),
                CustomTextFieldWidget(
                    controller: passwordController,
                    text: translateController.Enter_your_password,
                    password: true),
                const SizedBox(
                  height: 16,
                ),
                RichText(
                  text: TextSpan(
                    text:
                        '${translateController.By_using_the_app_you_agree_to_the} ',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: const Color(0xFF333333),
                    ),
                    children: <InlineSpan>[
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () {
                            launchUrl(Uri.parse(
                                'http://profe.1gb.ru/wp-content/uploads/2024/03/Privacy-Policy.pdf'));
                          },
                          child: Column(
                            children: <Widget>[
                              Text(
                                translateController.Privace_policy,
                                style: GoogleFonts.inter(
                                  decoration: TextDecoration.underline,
                                  height: 1.1,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: const Color(
                                    0xFFF14F44,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    if(
                    emailController.text.isNotEmpty && passwordController.text.isNotEmpty
                    ) {
                      if(passwordController.text.length > 8) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SetFreelancer1view(
                                  email: emailController.text,
                                  password: passwordController.text,
                                )));
                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Пароль слишком короткий'),backgroundColor: Colors.red,),);
                      }
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Заполните все поля!'),backgroundColor: Colors.red,),);
                    }
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
