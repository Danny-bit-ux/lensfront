import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../controller/edit_profile_controller.dart';
import '../../../../domain/user/auth/create_user.dart';
import '../../../../domain/user/get_user_profile.dart';

TextEditingController fieldController = TextEditingController();
FocusNode _focusNode = FocusNode();
class EditFieldView extends StatelessWidget {
  final String fieldName;
  final int id;
  final dynamic data;
  const EditFieldView({super.key, required this.fieldName, required this.id, required this.data});

  @override
  Widget build(BuildContext context) {
    final editProfileModel = context.read<EditProfileController>();
    final userModel = context.watch<GetUserProfile>();
    fieldController.text = data ?? '';
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(child: Image.asset('assets/design/images/arrowleft.png'),onTap: () {
                      Navigator.pop(context);
                    },),
                    const Text(
                      'Профиль',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  const SizedBox(width: 24,),
                  ],
                ),
                const SizedBox(height: 24,),
                Text(fieldName,style: const TextStyle(
                  fontSize: 22,
                ),),
                const SizedBox(height: 24,),
                TextField(
                  focusNode: _focusNode,
                  maxLines: 10,
                  minLines: 5,
                  maxLength: 1000,
                  controller: fieldController,
                  decoration: InputDecoration(

                    hintStyle: const TextStyle(
                      color: Color(
                        0xFFCBCBCB,
                      ),
                    ),
                    hintText: 'Заполните это поле',
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),),
                const SizedBox(height: 30,),
                GestureDetector(
                  onTap: () {
                   switch(id) {
                     case 1:
                        editProfileModel.userName = fieldController.text;
                       break;
                     case 2:
                       editProfileModel.userEmail = fieldController.text;
                       break;
                     case 3:
                       editProfileModel.userCity = fieldController.text;
                       break;
                     case 4:
                       editProfileModel.userDateOfBurn = fieldController.text;
                       break;
                     case 5:
                       editProfileModel.userCategory = fieldController.text;
                       break;
                     case 6:
                       editProfileModel.userSkills = fieldController.text;
                       break;
                     case 7:
                       editProfileModel.userEducation = fieldController.text;
                       break;
                     case 8:
                       editProfileModel.userExperience = fieldController.text;
                       break;
                     case 9:
                       editProfileModel.userAboutMe = fieldController.text;
                       break;
                     case 10:
                       editProfileModel.userClientVisiting = fieldController.text;
                       break;
                     default:
                   }
                    editProfileModel.updateProfileData(uid);
                Future.delayed(Duration(milliseconds: 300),(){
                  userModel.getUserProfile(uid);
                });
                   Navigator.pop(context);
                  },
                  child: Container(
                    height: 52,
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xffF14F44),
                    ),
                    child:  Center(
                      child: Text('Сохранить', style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white,
                      ),),
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
