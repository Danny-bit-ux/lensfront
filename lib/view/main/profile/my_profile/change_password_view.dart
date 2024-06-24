// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../controller/user_controller.dart';
import '../../../widgets/custom_textfield_widget.dart';

TextEditingController _oldPasswordController = TextEditingController();
TextEditingController _newPasswordController = TextEditingController();
TextEditingController _newPasswordConfirmController = TextEditingController();

class ChangePasswordView extends GetView<UserController> {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Смена пароля',
          style: GoogleFonts.inter(
            fontSize: 16,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Введите текущий пароль',
              style: GoogleFonts.inter(
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 24,),
            CustomTextFieldWidget(controller: _oldPasswordController, text: 'Введите пароль', password: true),
            const SizedBox(height: 24,),
            Text(
              'Введите новый пароль',
              style: GoogleFonts.inter(
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 24,),
            CustomTextFieldWidget(controller: _newPasswordController, text: 'Введите пароль', password: true),
            const SizedBox(height: 24,),
            CustomTextFieldWidget(controller: _newPasswordConfirmController, text: 'Введите пароль', password: true),
            const SizedBox(height: 35,),
            GestureDetector(
              onTap: () async {
                if(_newPasswordController.text == _newPasswordConfirmController.text) {
                bool success = await controller.updateUserPassword(newPassword: _newPasswordController.text, lastPassword: _oldPasswordController.text);
                if(success == true) {
                  Navigator.pop(context);
                }
                else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 35,
                        color: Colors.red.shade300,
                        child: const Center(
                          child: Text('Неверный пароль'),
                        ),
                      )));
                }
                }
                else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 35,
                        color: Colors.red.shade300,
                        child: const Center(
                          child: Text('Пароли не сопадают'),
                        ),
                      )));
                }
              },
              child: Container(
                height: 52,
                width: MediaQuery.of(context).size.width -32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xffF14F44),
                ),
                child: Center(
                  child: Text('Поменять',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                  ),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
