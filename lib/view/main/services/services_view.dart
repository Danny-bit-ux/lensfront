// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../ServerRoutes.dart';
import '../../../controller/services_controller.dart';
import '../../../domain/get_citys_list.dart';
import '../../../domain/user/auth/create_user.dart';
import '../../auth/registration/registration_freelancer_view/citys_list_screen.dart';
import '../../no_login/no_login_services.dart';
import '../../widgets/draver_widget.dart';
import '../all_categories.dart';
import '../profile/my_profile/service/my_services.dart';
import 'customer_requests.dart';

TextEditingController _textEditingController = TextEditingController();

class ServicesView extends GetView<ServicesController> {
  const ServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ServicesController());
    controller.getAllServices('');
    controller.getMyServices(uid);
    final image = NetworkImage('${ServerRoutes.host}/avatar?path=avatar_$uid');
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        drawer: const DrawerWidget(),
        body: SafeArea(
          child: GestureDetector(
            child: ListView(children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                    vertical: MediaQuery.of(context).size.height / 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          backgroundImage: image,
                          child: Builder(builder: (context) {
                            return IconButton(
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                              icon: Icon(
                                Icons.person,
                                color: Colors.white.withOpacity(0),
                              ),
                              color: Colors.grey,
                              iconSize: 32,
                            );
                          }),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width - 100,
                            height: 41,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(12)),
                            child: MaterialButton(
                              onPressed: () {},
                              child: TextField(
                                controller: _textEditingController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Поиск",
                                    prefixIcon: const Icon(Icons.search),
                                    prefixStyle:
                                        GoogleFonts.inter(color: Colors.grey)),
                              ),
                            )),
                        IconButton(
                            onPressed: () {
                              controller
                                  .getAllServices(_textEditingController.text);
                            },
                            icon: const Icon(Icons.send,color: Color(0xffD0D4B1),)),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const MyServiceBlock(),
                    const SizedBox(
                      height: 12,
                    ),
                    const MyBookingBlock(),
                    const SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.bottomSheet(const FiltersMenu());
                      },
                      child: Container(

                        decoration: BoxDecoration(
                          color: const Color(0xffD0D4B1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Фильтры',style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Column(
                      children:
                          List.generate(controller.allServices.length, (index) {
                        final item = controller.allServices[index];
                        return NewServiceCardWidget(item: item, order: false);
                      }),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class MyServiceBlock extends GetView<ServicesController> {
  const MyServiceBlock({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ServicesController());
    return controller.myServices.isNotEmpty
        ? GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (controller) =>  MyServices(
                            my: true,id: uid,
                          )));
            },
            child: Container(
              height: 52,
              width: MediaQuery.of(context).size.width - 32,
              decoration: BoxDecoration(
                color: const Color(0xffFFFFFF),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color:  const Color(0xffD0D4B1)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Мои услуги',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CircleAvatar(
                      radius: 17.5,
                      backgroundColor:  const Color(0xffD0D4B1),
                      child: Center(
                        child: Text(
                          controller.myServices.length.toString(),
                          style: GoogleFonts.inter(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : const SizedBox();
  }
}

TextEditingController _minPriceController = TextEditingController();
TextEditingController _maxPriceController = TextEditingController();

class ChangePriceBottomSheet extends GetView<ServicesController> {
  const ChangePriceBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ServicesController());
    return Container(
      height: 300,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: GestureDetector(
                      child: Image.asset(
                        'assets/design/images/arrowleft.png',
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      }),
                ),
                Text(
                  'Цена',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      _maxPriceController.clear();
                      _minPriceController.clear();
                      controller.searchPriceMin.value = '0';
                      controller.searchPriceMax.value = '9999999';
                    },
                    child: const Text('Сбросить'))
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2 - 26,
                  child: TextField(
                    controller: _minPriceController,
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(
                        color: Color(
                          0xFFCBCBCB,
                        ),
                      ),
                      hintText: 'От €',
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
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2 - 26,
                  child: TextField(
                    onChanged: (_) {},
                    controller: _maxPriceController,
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(
                        color: Color(
                          0xFFCBCBCB,
                        ),
                      ),
                      hintText: 'До €',
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
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          GestureDetector(
            onTap: () {
              if (_minPriceController.text.isNotEmpty) {
                controller.searchPriceMin.value = _minPriceController.text;
              }
              if (_maxPriceController.text.isNotEmpty) {
                controller.searchPriceMax.value = _maxPriceController.text;
              }
              controller.getAllServices(_textEditingController.text);
              Navigator.pop(context);
            },
            child: Container(
              height: 52,
              width: MediaQuery.of(context).size.width - 32,
              decoration: BoxDecoration(
                color:  const Color(0xffD0D4B1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  'Применить',
                  style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChangeRatingBottomSheet extends GetView<ServicesController> {
  const ChangeRatingBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ServicesController());
    return Obx(
      () => Container(
        height: 390,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 30.0),
                      child: GestureDetector(
                          child: Image.asset(
                            'assets/design/images/arrowleft.png',
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          }),
                    ),
                    Text(
                      'Рейтинг',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          controller.searchRatingMin.value = '0';
                        },
                        child: const Text('Сбросить'))
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.searchRatingMin.value = '3.9';
                    },
                    child: Container(
                      height: 22,
                      width: 22,
                      decoration: controller.searchRatingMin.value != '3.9'
                          ? BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              border:
                                  Border.all(color: const Color(0xff3333333)))
                          : BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(100),
                            ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Исполнители от 4',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: const Color(0xff808080),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  SvgPicture.asset(
                    'assets/design/images/mini_star.svg',
                    color: const Color(0xffF9CF3A),
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              const Divider(),
              const SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.searchRatingMin.value = '4.4';
                    },
                    child: Container(
                      height: 22,
                      width: 22,
                      decoration: controller.searchRatingMin.value != '4.4'
                          ? BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              border:
                                  Border.all(color: const Color(0xff3333333)))
                          : BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(100),
                            ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Исполнители от 4.5',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: const Color(0xff808080),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  SvgPicture.asset(
                    'assets/design/images/mini_star.svg',
                    color: const Color(0xffF9CF3A),
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              const Divider(),
              const SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.searchRatingMin.value = '4.9';
                    },
                    child: Container(
                      height: 22,
                      width: 22,
                      decoration: controller.searchRatingMin.value != '4.9'
                          ? BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              border:
                                  Border.all(color: const Color(0xff3333333)))
                          : BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(100),
                            ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Исполнители 5',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: const Color(0xff808080),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  SvgPicture.asset(
                    'assets/design/images/mini_star.svg',
                    color: const Color(0xffF9CF3A),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              GestureDetector(
                onTap: () {
                  controller.getAllServices(_textEditingController.text);
                  Navigator.pop(context);
                },
                child: Container(
                  height: 52,
                  width: MediaQuery.of(context).size.width - 32,
                  decoration: BoxDecoration(
                    color: const Color(0xffF14F44),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'Применить',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
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

class MyBookingBlock extends GetView<ServicesController> {
  const MyBookingBlock({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ServicesController());
    controller.getCustomerBooking();
    return Obx(() => controller.customerBooking.isNotEmpty
        ? GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (controller) => const CustomerRequestView()));
            },
            child: Container(
              height: 52,
              width: MediaQuery.of(context).size.width - 32,
              decoration: BoxDecoration(
                color: const Color(0xffFFFFFF),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xffF14F44)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Мои записи',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CircleAvatar(
                      radius: 17.5,
                      backgroundColor: const Color(0xffF14F44),
                      child: Center(
                        child: Text(
                          controller.customerBooking.length.toString(),
                          style: GoogleFonts.inter(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : const SizedBox());
  }
}

class FiltersMenu extends GetView<ServicesController> {
  const FiltersMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final citysModel = Provider.of<GetCitysList>(context);
    Get.put(ServicesController());
    return Container(
      height: 300,
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AllCategoriesView(
                                  services: true,
                                )));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: controller.searchCategory.value == 'no'
                          ? const Color(0xff333333)
                          : const Color(0xffF14F44),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12),
                      child: Text(
                        controller.searchCategory.value == 'no'
                            ? 'Категория'
                            : controller.searchCategory.value,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8,),
                GestureDetector(
                  onTap: () {
                    Get.bottomSheet(const ChangePriceBottomSheet());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: controller.searchPriceMax.value == '9999999' &&
                              controller.searchPriceMin.value == '0'
                          ? const Color(0xff333333)
                          : const Color(0xffF14F44),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12),
                      child: Text(
                        controller.searchPriceMax.value == '9999999' &&
                                controller.searchPriceMin.value == '0'
                            ? 'Цена'
                            : ''
                                'От ${controller.searchPriceMin.value} до ${controller.searchPriceMax.value}',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8,),
                GestureDetector(
                  onTap: () {
                    Get.bottomSheet(const ChangeRatingBottomSheet());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: controller.searchRatingMin.value == '0'
                          ? const Color(0xff333333)
                          : const Color(0xffF14F44),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12),
                      child: Text(
                        controller.searchRatingMin.value == '0'
                            ? 'Рейтинг'
                            : 'От ${controller.searchRatingMin.value}',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8,),
                GestureDetector(
                  onTap: () {
                    controller.clearFilters();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff333333),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12),
                      child: Text(
                        'Сбросить фильтры',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CitysListView(
                              profile: false,
                              service: true,
                            )));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: controller.searchCity.value == 'no'
                          ? const Color(0xff333333)
                          : const Color(0xffF14F44),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12),
                      child: Text(
                        controller.searchCity.value == 'no'
                            ? 'Город'
                            : controller.searchCity.value,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
