// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../ServerRoutes.dart';
import '../../../controller/services_controller.dart';
import '../../../domain/user/get_user_profile.dart';
import '../../no_login/no_login_services.dart';
import '../profile/other_profile/other_freelancer_profile_view.dart';

final startData = DateTime.now();
DateTime dateTime = DateTime.now();
FocusNode _focusNode = FocusNode();
TextEditingController _descriptionController = TextEditingController();

class OpenServiceView extends GetView<ServicesController> {
  final dynamic item;
  const OpenServiceView({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    Get.put(ServicesController());
    final image =
        NetworkImage('${ServerRoutes.host}/avatar?path=avatar_${item['uid']}');
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Scaffold(
          backgroundColor: const Color(0xffFAFAFA),
          appBar: AppBar(
            title: Text(item['name'],),
            centerTitle: true,
            backgroundColor: const Color(0xffFAFAFA),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Рабочие дни:',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        item['monday'] == '1'
                            ? const Text('Пн,')
                            : const SizedBox(),
                        item['tuesday'] == '1'
                            ? const Text('Вт,')
                            : const SizedBox(),
                        item['wednesday'] == '1'
                            ? const Text('Ср,')
                            : const SizedBox(),
                        item['thursday'] == '1'
                            ? const Text('Чт,')
                            : const SizedBox(),
                        item['friday'] == '1'
                            ? const Text('Пт,')
                            : const SizedBox(),
                        item['saturday'] == '1'
                            ? const Text('Сб,')
                            : const SizedBox(),
                        item['sunday'] == '1'
                            ? const Text('Вс')
                            : const SizedBox(),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          'Часы работы:',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        item['time'].toString().length > 3?         Text(
                            '${item['time'].toString().substring(0, 2)}:00-${item['time'].toString().substring(2, 4)}:00'):const Text('Нет рабочего графика'),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          'Цена:',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          item['fixPrice'] == '0' && item['hourPrice'] == '1'
                              ? 'От ${item['price_min']}€ в час'
                              : item['fixPrice'] == '0'
                                  ? 'От ${item['price_min']}€'
                                  : item['hourPrice'] == '1'
                                      ? '${item['price_min']}€ в час'
                                      : '${item['price_min']}€',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final userModel =
                            Provider.of<GetUserProfile>(context, listen: false);
                        final user =
                            await userModel.getOtherUserProfile(item['uid']);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    OtherFreelancerProfileView(
                                        thisUid: item['uid'],
                                        userModel: user)));
                      },
                      child: Container(
                        height: 88,
                        width: MediaQuery.of(context).size.width - 32,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CircleAvatar(radius: 32, backgroundImage: image),
                              const SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    item['freelancer_name'].toString(),
                                    style: GoogleFonts.inter(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        item['freelancer_rating'],
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xffF9CF3A)),
                                      ),
                                      SvgPicture.asset(
                                        'assets/design/images/mini_star.svg',
                                        color: const Color(0xffF9CF3A),
                                        height: 24,
                                        width: 24,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                          getReviewsString(
                                              int.parse(item['reviews'].toString())),
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: const Color(0xff808080),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                     Text(
                      'Записаться к специалисту',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Obx(() {
                      return SizedBox(
                        child: TableCalendar(
                          focusedDay: DateTime.now(),
                          firstDay: DateTime.now(),
                          lastDay: DateTime.now().add(
                            const Duration(days: 30),
                          ),
                          headerStyle: const HeaderStyle(
                              formatButtonVisible: false,
                              leftChevronIcon: Icon(
                                Icons.chevron_left,
                                color: Colors.red,
                              ),
                              rightChevronIcon: Icon(
                                Icons.chevron_right,
                                color: Colors.red,
                              )),
                          calendarStyle: CalendarStyle(
                            todayDecoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          currentDay: controller.requestDay.value,
                          onDaySelected: (_, day) {
                            controller.requestDay.value = day;
                          },
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text('Описание'),
                    const SizedBox(
                      height: 12,
                    ),
                    TextField(
                      focusNode: _focusNode,
                      maxLines: 10,
                      minLines: 5,
                      maxLength: 1000,
                      controller: _descriptionController,
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
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.bookService(
                            sid: item['id'],
                            description: _descriptionController.text,
                            date: controller.requestDay.value.toString(),
                            freelancerId: item['uid']);
                        Navigator.pop(context);
                        showDialog<void>(
                          context: context,
                          barrierDismissible:
                          false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                'Вы успешно записались!',
                                textAlign: TextAlign.center,
                              ),
                              content: const SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text(
                                      'Ожидайте ответа исполнителя',
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: 52,
                                    width: MediaQuery.of(context).size.width -32,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Center(
                                      child: Text('Закрыть',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),),
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 52,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Записаться',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
