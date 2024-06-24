// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../../ServerRoutes.dart';
import '../../../../controller/edit_profile_controller.dart';
import '../../../../domain/get_citys_list.dart';
import '../../../../domain/user/auth/create_user.dart';
import '../../../auth/registration/registration_freelancer_view/citys_list_screen.dart';
import 'edit_field_view.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({
    super.key,
  });

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  @override
  Widget build(BuildContext context) {
    final editProfileModel = context.watch<EditProfileController>();
    final citysModel = context.watch<GetCitysList>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Image.asset('assets/design/images/arrowleft.png'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Text(
                      'Профиль',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      width: 13,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Stack(
                  children: [
                    const Center(
                      child: CircleAvatar(
                        radius: 45,
                        backgroundImage: AssetImage('assets/dwd_logo.jpeg'),
                        // AssetImage('assets/dwd_logo.jpeg'),
                      ),
                    ),
                    Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0),
                        radius: 45,
                        backgroundImage: NetworkImage(
                            '${ServerRoutes.host}/avatar?path=avatar_$uid'),
                        // AssetImage('assets/dwd_logo.jpeg'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    _main();
                  },
                  child: Container(
                    height: 39,
                    width: 194,
                    decoration: BoxDecoration(
                      color: const Color(0xffD9D9D9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text('Изменить фотографию'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                EditCardWidget(
                    id: 1,
                    field: true,
                    data: editProfileModel.userName,
                    paramets: 'Ваше имя'),
                EditCardWidget(
                    id: 2,
                    field: true,
                    data: editProfileModel.userEmail,
                    paramets: 'Ваша почта'),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CitysListView(profile: true,service: false,)));
                  },
                  child: EditCardWidget(
                      id: 3,
                      field: false,
                      data:  citysModel.selectedCity,
                      paramets: 'Ваш город'),
                ),
                GestureDetector(
                  onTap: (){
                    DatePicker.showDatePicker(
                      context,
                      pickerMode: DateTimePickerMode.date,
                      initialDateTime:
                      DateTime.now().add(const Duration(days: 5)),
                      minDateTime: DateTime(1950, 1, 0, 0, 0, 0, 0, 0),
                      maxDateTime: DateTime.now(),
                      locale: DateTimePickerLocale.ru,
                      dateFormat: "dd MMMM yyyy",
                      onChange: (dateTime, selectedIndex) {
                        editProfileModel.userDateOfBurn  =
                            dateTime.toString().substring(0, 10);
                        editProfileModel.updateProfileData(uid);
                        setState(() {

                        });
                      },
                      onConfirm: (dateTime, selectedIndex) {
                        editProfileModel.userDateOfBurn =
                            dateTime.toString().substring(0, 10);
                        editProfileModel.updateProfileData(uid);
                        setState(() {

                        });
                      },
                    );
                  },
                  child: EditCardWidget(
                      id: 4,
                      field: false,
                      data: editProfileModel.userDateOfBurn,
                      paramets: 'Дата рождения'),
                ),
                const SizedBox(
                  height: 12,
                ),
                EditBigCardWidget(
                    id: 6,
                    data: editProfileModel.userSkills == 'null' ? 'Не указан' : editProfileModel.userSkills,
                    paramets: 'Навыки'),
                EditBigCardWidget(
                    id: 7,
                    data: editProfileModel.userEducation == 'null' ? 'Не указан' : editProfileModel.userEducation,
                    paramets: 'Образование'),
                EditBigCardWidget(
                    id: 8,
                    data: editProfileModel.userExperience == 'null' ? 'Не указан' : editProfileModel.userExperience,
                    paramets: 'Опыт'),
                EditBigCardWidget(
                    id: 9,
                    data: editProfileModel.userAboutMe == 'null' ? 'Не указан' : editProfileModel.userAboutMe,
                    paramets: 'О себе'),
                EditBigCardWidget(
                    id: 10,
                    data: editProfileModel.userClientVisiting,
                    paramets: 'Выезд к клиенту'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EditCardWidget extends StatelessWidget {
  final bool field;
  final id;
  final paramets;
  final data;
  const EditCardWidget(
      {super.key,
      required this.id,
      required this.data,
      required this.paramets,
      required this.field});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                paramets,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff808080),
                ),
              ),
              field == true ?      GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditFieldView(
                              fieldName: paramets,
                              id: id,
                              data: data,
                            )));
                  },
                  child: Image.asset('assets/design/images/pencil.png')) : SizedBox(),
            ],
          ),
          const SizedBox(
            height: 12,
          ),


              Text(
                data.toString(),
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),

          const SizedBox(
            height: 12,
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width - 40,
            color: const Color(0xffEBEBEB),
          ),
        ],
      ),
    );
  }
}

class EditBigCardWidget extends StatelessWidget {
  final id;
  final paramets;
  final data;
  const EditBigCardWidget(
      {super.key,
      required this.id,
      required this.data,
      required this.paramets});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                paramets.toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditFieldView(
                                  fieldName: paramets,
                                  id: id,
                                  data: data,
                                )));
                  },
                  child: Image.asset('assets/design/images/pencil.png')),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            data.toString(),
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width - 40,
            color: const Color(0xffEBEBEB),
          ),
        ],
      ),
    );
  }
}

Future<void> uploadImage(File imageFile) async {
  var url = Uri.parse('${ServerRoutes.host}/add_avatar');

  List<int> imageBytes = imageFile.readAsBytesSync();
  String base64Image = base64Encode(imageBytes);

  var requestBody = jsonEncode({
    'image': {'data': base64Image, 'name': 'avatar_$uid.jpg'}
  });

  var response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: requestBody,
  );

  if (response.statusCode == 200) {
    print('Image uploaded successfully');
  } else {
    print('Failed to upload image');
  }
}

void _main() async {
  final imagePicker = ImagePicker();
  final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery,imageQuality: 13);

  if (pickedFile != null) {
    File imageFile = File(pickedFile.path);

    await uploadImage(imageFile);
  }
}
