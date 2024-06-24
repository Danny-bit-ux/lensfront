import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newlensfront/view/auth/registration/registration_freelancer_view/set_freelance_add_photo_view.dart';
import 'package:provider/provider.dart';
import '../../../../domain/get_citys_list.dart';
import '../../../../main.dart';
import 'citys_list_screen.dart';

TextEditingController _nameController = TextEditingController();
TextEditingController _dateOfBurnController = TextEditingController();

class SetFreelancer1view extends StatelessWidget {
  String email;
  String password;
  SetFreelancer1view({super.key, required this.email, required this.password});

  @override
  Widget build(BuildContext context) {
    final citysModel = context.watch<GetCitysList>();
    return Scaffold(
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
                        Navigator.pop(context);
                      },
                      child: Image.asset('assets/design/images/arrowleft.png')),
                  Text(
                    'Стать исполнителем',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset('assets/design/images/cross.png')),
                ],
              ),
              const SizedBox(
                height: 9,
              ),
              Text(
                translateController.How_to_introduce_you_to_customers_q,
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                translateController.To_be_trusted_provide_reliable_information,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: const Color(0xff808080)),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                translateController.Your_name_and_surname,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff808080),
                ),
              ),
              TextField(
                controller: _nameController,
                style: GoogleFonts.inter(
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                    hintText: 'ФИО',
                    hintStyle: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    )),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                translateController.Your_city,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff808080),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CitysListView(profile: false,service: false,)));
                    },
                    child: Text(
                      citysModel.selectedCity,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Image.asset('assets/design/images/arrowright.png'),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width - 20,
                color: const Color(0xff808080),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
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
                        _dateOfBurnController.text =
                            dateTime.toString().substring(0, 10);
                      },
                      onConfirm: (dateTime, selectedIndex) {
                        _dateOfBurnController.text =
                            dateTime.toString().substring(0, 10);
                      },
                    );
                  },
                  child: TextField(
                    enabled: false,
                    controller: _dateOfBurnController,
                    decoration: InputDecoration(
                        hintText: 'Дата рождения',
                        hintStyle: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        )),
                  ),
                ),
              ),
              const Text('Дата рождения не будет видна другим пользователям',
              style: TextStyle(
                color: Color(0xff808080),
                fontWeight: FontWeight.w300,
                fontSize: 12,
              ),),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 45),
        child: GestureDetector(
          onTap: () {
            if(_nameController.text.isNotEmpty || _dateOfBurnController.text.isNotEmpty) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SetFreelancerAddPhotoView(
                            name: _nameController.text,
                            email: email,
                            password: password,
                            city: citysModel.selectedCity,
                            date_of_burn: _dateOfBurnController.text,
                          )));
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
      ),
    );
  }
}
