// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../domain/user/auth/create_user.dart';
import '../../../domain/user/get_user_profile.dart';
import '../../../main.dart';
import '../../main_view.dart';
import '../../widgets/custom_textfield_widget.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class LoginFirstView extends StatelessWidget {
  const LoginFirstView({super.key});

  @override
  Widget build(BuildContext context) {
    final authModel = context.read<CreateUser>();
    final getProfile = context.read<GetUserProfile>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Image.asset('assets/design/images/cross.png'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    translateController.entrance,
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
                translateController.PleaseEnterYourEmail,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 24),
              CustomTextFieldWidget(
                controller: emailController,
                text: translateController.Enter_an_email,
                password: false,
              ),
              const SizedBox(
                height: 12,
              ),
              CustomTextFieldWidget(
                controller: passwordController,
                text: translateController.Enter_your_password,
                password: true,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: GestureDetector(
                  onTap: () async {
                    var check = await authModel.authUserFromEmail(
                        emailController.text, passwordController.text);
                    if (check != null) {
                      getProfile.getUserProfile(int.parse(check));
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainView()),
                          (route) => false);
                      FlutterSecureStorage flutterSecureStorage =
                          const FlutterSecureStorage();
                      flutterSecureStorage.write(key: 'uid', value: check);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 35,
                        color: Colors.red.shade300,
                        child: const Center(
                          child: Text('Неверный логин или пароль'),
                        ),
                      )));
                    }
                  },
                  child: Container(
                    height: 52,
                    width: MediaQuery.of(context).size.width - 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xffACC1B4),
                    ),
                    child: Center(
                      child: Text(translateController.Login,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white,
                          )),
                    ),
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
