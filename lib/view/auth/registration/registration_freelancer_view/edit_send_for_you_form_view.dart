import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../controller/send_for_user_controller.dart';


TextEditingController parametsController = TextEditingController();
FocusNode _focusNode = FocusNode();

void unfoc() {
  _focusNode.unfocus();
}
class EditSendForYouFormView extends StatelessWidget {
  final String name;
  final int id;
  final String nameView;
  const EditSendForYouFormView({super.key, required this.name, required this.nameView, required this.id});

  @override
  Widget build(BuildContext context) {
    final editModel = context.read<SendForUserController>();
    switch(id) {
      case 1:
        if(editModel.skills != null) {
          parametsController.text = editModel.skills;
        }
        break;
      case 2:
        if(editModel.education != null) {
          parametsController.text = editModel.education;
        }
        break;
      case 3:
        if(editModel.experience != null) {
          parametsController.text = editModel.experience;
        }
        break;
      case 4:
        if(editModel.about_me != null) {
          parametsController.text = editModel.about_me;
        }
        break;
      case 5:
        if(editModel.client_visiting != null) {
          parametsController.text = editModel.client_visiting;
        }
        break;
    }
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
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
                        parametsController.clear();
                        Navigator.pop(context);
                      },
                        child: Image.asset('assets/design/images/arrowleft.png')),
                     Text(
                      'Шаг 3 из 4',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        parametsController.clear();
                        Navigator.pop(context);
                      },
                        child: Image.asset('assets/design/images/cross.png')),
                  ],
                ),
                const SizedBox(height: 25,),
                Text(name, style: const TextStyle(
                  fontSize: 22,
                ),),
                const SizedBox(height: 16,),
            TextField(
              focusNode: _focusNode,
              maxLines: 10,
              minLines: 5,
              maxLength: 1000,
              controller: parametsController,
              decoration: InputDecoration(

                hintStyle:  GoogleFonts.inter(
                  color: const Color(
                    0xFFCBCBCB,
                  ),
                ),
                hintText: 'Напишите важные детали для специалиста',
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
                const SizedBox(height: 33,),
                GestureDetector(
                  onTap: () {
                    switch(id) {
                      case 1:
                        editModel.editSkills(parametsController.text);
                        break;
                      case 2:
                        editModel.editEducation(parametsController.text);
                        break;
                      case 3:
                        editModel.editExperience(parametsController.text);
                        break;
                      case 4:
                        editModel.editAboutMe(parametsController.text);
                        break;
                      case 5:
                        editModel.editClientVisiting(parametsController.text);
                        break;
                    }
                    parametsController.clear();
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const  Color(0xffACC1B4),
                    ),
                    child:  Center(
                      child: Text('Сохранить',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xffFAFAFA),
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
