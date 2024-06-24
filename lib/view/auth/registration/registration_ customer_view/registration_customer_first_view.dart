// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../domain/get_citys_list.dart';
import '../../../../domain/user/auth/create_user.dart';
import '../../../../main.dart';
import '../../../main_view.dart';
import '../../../widgets/custom_textfield_widget.dart';
import '../registration_freelancer_view/citys_list_screen.dart';

TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class RegistrationCustomerFirstView extends StatelessWidget {
  const RegistrationCustomerFirstView({super.key});

  @override
  Widget build(BuildContext context) {
    final createUserModel = context.read<CreateUser>();
    final citysModel = context.watch<GetCitysList>();
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
                const SizedBox(height: 24,),
                Text(
                  translateController.Please_enter_your_details,
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
                ),
                const SizedBox(height: 16,),
                CustomTextFieldWidget(controller: nameController, text: translateController.Enter_your_name, password: false),
                const SizedBox(height: 16,),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CitysListView(profile: false,service: false,)));
                },
                child: Container( height: 52,
                  width: MediaQuery.of(context).size.width -32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black,width: 0.7),
                  ), child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 16),
                  child: Text(
                    citysModel.selectedCity,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                ),


          ),
                const SizedBox(height: 16,),
                CustomTextFieldWidget(controller: emailController, text: translateController.Enter_an_email, password: false),
                const SizedBox(height: 16,),
                CustomTextFieldWidget(controller: passwordController, text: translateController.Enter_your_password, password: true),
                const SizedBox(height: 16,),
                RichText(
                  text: TextSpan(
                    text: translateController.By_using_the_app_you_agree_to_the,
                    style:  GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: const Color(0xFF333333),
                    ),
                    children: <InlineSpan>[
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () {
                            launchUrl(Uri.parse('http://profe.1gb.ru/wp-content/uploads/2024/03/Privacy-Policy.pdf'));
                          },
                          child:  Column(
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
                const SizedBox(height: 30,),
                GestureDetector(
                  onTap: () async {
                    if(nameController.text.isNotEmpty && emailController.text.isNotEmpty && passwordController.text.isNotEmpty ) {
                      if(citysModel.selectedCity != 'Не выбран') {
                        await createUserModel.createUser(name: nameController.text,  email: emailController.text, age: null, freelancer: false, last_login: DateTime.now().toString(), password_hash: passwordController.text, city:  citysModel.selectedCity, country: null, date_of_burn: null, avatar: null, spheres: null, skills: null, education: null, experience: null, about_me: null, client_visiting: null, servises: null, rating: null, reviews: null, email_succes: true,categories: []);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const MainView()));
                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Выберите город')));
                      }
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Заполните все данные')));
                    }
                  },
                  child: Container(
                    height: 52,
                    width: MediaQuery.of(context).size.width - 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const  Color(0xffACC1B4),
                    ),
                    child:  Center(
                      child: Text(translateController.Continue, style: GoogleFonts.inter(
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
