// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../controller/services_controller.dart';
import '../../../../../domain/user/auth/create_user.dart';
import '../../../../widgets/custom_textfield_widget.dart';
import 'create_service_set_category_view.dart';

TextEditingController _categoryController = TextEditingController();
TextEditingController _nameController = TextEditingController();
TextEditingController _priceController = TextEditingController();
TextEditingController _descriptionController = TextEditingController();

class CreateServicesView extends GetView<ServicesController> {
  const CreateServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ServicesController());
    return Obx(
      () => Scaffold(
        backgroundColor: const Color(0xffFAFAFA),
        appBar: AppBar(
          title: const Text('Создать услугу'),
          centerTitle: true,
          backgroundColor: const Color(0xffFAFAFA),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const CreateServiceSelectCategory()));
                    },
                    child: Container(
                      height: 52,
                      width: MediaQuery.of(context).size.width - 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4.0, vertical: 14),
                        child: Text(
                          controller.category.value,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextFieldWidget(
                      controller: _nameController,
                      text: "Название услуги",
                      password: false),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextFieldWidget(
                      controller: _descriptionController,
                      text: "Описание",
                      password: false),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextFieldWidget(
                    controller: _priceController,
                    text: "Стоимость",
                    password: false,
                    textInputType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      CupertinoSwitch(
                          value: controller.fixPrice.value,
                          onChanged: (_) {
                            controller.switcher(controller.fixPrice);
                          }),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Фиксированная цена',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      CupertinoSwitch(
                          value: controller.hourPrice.value,
                          onChanged: (_) {
                            controller.switcher(controller.hourPrice);
                          }),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Цена за час',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DayCard(
                        title: 'Пн',
                        index: 0,
                      ),
                      DayCard(
                        title: 'Вт',
                        index: 1,
                      ),
                      DayCard(
                        title: 'Ср',
                        index: 2,
                      ),
                      DayCard(
                        title: 'Чт',
                        index: 3,
                      ),
                      DayCard(
                        title: 'Пт',
                        index: 4,
                      ),
                      DayCard(
                        title: 'Сб',
                        index: 5,
                      ),
                      DayCard(
                        title: 'Вс',
                        index: 6,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      CupertinoSwitch(
                          value: controller.fixTime.value,
                          onChanged: (_) {
                            controller.switcher(controller.fixTime);
                          }),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Есть рабочий график',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  controller.fixTime.value == true
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 42.0, vertical: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Начало',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    'Конец',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 150,
                                  width: MediaQuery.of(context).size.width / 2 -
                                      32,
                                  child: ListWheelScrollView(
                                      itemExtent: 30,
                                      children: List.generate(
                                          controller.hours.length,
                                          (index) => StartTimeCard(
                                                title: controller
                                                    .hours.value[index].title,
                                                time: controller
                                                    .hours.value[index].time,
                                              ))),
                                ),
                                SizedBox(
                                  height: 150,
                                  width: MediaQuery.of(context).size.width / 2 -
                                      32,
                                  child: ListWheelScrollView(
                                      itemExtent: 30,
                                      children: List.generate(
                                          controller.hours.length,
                                          (index) => EndTimeCard(
                                                title: controller
                                                    .hours.value[index].title,
                                                time: controller
                                                    .hours.value[index].time,
                                              ))),
                                ),
                              ],
                            ),
                          ],
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 32,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.createServise(
                          globalCategory: controller.globalCategory.value,
                          name: _nameController.text,
                          categoryId: controller.categoryId.value,
                          categoryName: controller.category.value,
                          description: _descriptionController.text,
                          price: _priceController.text);
                      _nameController.clear();
                      controller.categoryId.value = 0;
                      controller.category.value = '';
                      _descriptionController.clear();
                      _priceController.clear();
                      controller.days.value = [
                        false,
                        false,
                        false,
                        false,
                        false,
                        false,
                        false,
                      ];
                      Future.delayed(const Duration(milliseconds: 130), () {
                        controller.getMyServices(uid);
                        controller.getAllServices('');
                      });
                      Navigator.pop(context);
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'Ваша услуга создана!',
                              textAlign: TextAlign.center,
                            ),
                            content: const SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text(
                                    'Теперь пользователи её увидят!',
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
                                  width: MediaQuery.of(context).size.width - 32,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Закрыть',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
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
                      width: MediaQuery.of(context).size.width - 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.red,
                      ),
                      child: Center(
                        child: Text(
                          'Создать',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DayCard extends GetView<ServicesController> {
  final String title;
  final index;
  const DayCard({super.key, required this.index, required this.title});

  @override
  Widget build(BuildContext context) {
    Get.put(ServicesController());
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0),
        child: GestureDetector(
          onTap: () {
            controller.setMn(index);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: controller.days[index] == false
                  ? Colors.grey.shade300
                  : Colors.red,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 16),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StartTimeCard extends GetView<ServicesController> {
  final title;
  final time;
  const StartTimeCard({super.key, required this.title, required this.time});

  @override
  Widget build(BuildContext context) {
    Get.put(ServicesController());
    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.setStartTime(time);
        },
        child: Container(
          height: 75,
          width: 100,
          color: controller.startTime.value != time
              ? Colors.grey.shade300
              : Colors.red,
          child: Center(
            child: Text(title),
          ),
        ),
      ),
    );
  }
}

class EndTimeCard extends GetView<ServicesController> {
  final String title;
  final int time;
  const EndTimeCard({super.key, required this.title, required this.time});

  @override
  Widget build(BuildContext context) {
    Get.put(ServicesController());
    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.endTime(time);
        },
        child: Container(
          height: 75,
          width: 100,
          color: controller.endTime.value != time
              ? Colors.grey.shade300
              : Colors.red,
          child: Center(
            child: Text(title),
          ),
        ),
      ),
    );
  }
}
