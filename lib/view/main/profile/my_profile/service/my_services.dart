import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../../ServerRoutes.dart';
import '../../../../../controller/services_controller.dart';
import '../../../../../domain/user/get_user_profile.dart';
import '../../../../no_login/no_login_home.dart';
import '../../other_profile/other_freelancer_profile_view.dart';
import 'create_services_view.dart';

class MyServices extends GetView<ServicesController> {
  final bool my;
  final id;
  const MyServices({super.key, required this.my, required this.id});

  @override
  Widget build(BuildContext context) {
    Get.put(ServicesController());
    controller.getMyServices(id);
    controller.getMyArchiveServices();
    return Scaffold(
      floatingActionButton: my == true
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateServicesView()));
              },
              child: const Icon(Icons.add),
            )
          : null,
      appBar: AppBar(
        title: Text(my == true ? 'Мои услуги' : 'Услуги исполнителя'),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xffFAFAFA),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Obx(
          () => Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.selectType(false);
                    },
                    child: Container(
                      height: 43,
                      width: MediaQuery.of(context).size.width / 2 - 23,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: controller.archive.value == true
                            ? Colors.grey.shade300
                            : Colors.red,
                      ),
                      child: const Center(
                        child: Text('Активные'),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.selectType(true);
                    },
                    child: Container(
                      height: 43,
                      width: MediaQuery.of(context).size.width / 2 - 23,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: controller.archive.value == false
                            ? Colors.grey.shade300
                            : Colors.red,
                      ),
                      child: const Center(
                        child: Text('Архив'),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Expanded(
                child: ListView(
                  children: List.generate(
                      controller.archive.value == false
                          ? controller.myServices.length
                          : controller.archiveServices.length, (index) {
                    final item = controller.archive.value == false
                        ? controller.myServices[index]
                        : controller.archiveServices[index];
                    return ServiceCardWidget(
                      item: item,
                      order: false,
                      my: true,
                      archive:    controller.archive.value,
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceCardWidget extends GetView<ServicesController> {
  final item;
  final bool order;
  final bool my;
  final bool archive;
  const ServiceCardWidget(
      {super.key, required this.item, required this.order, required this.my,required this.archive});

  @override
  Widget build(BuildContext context) {
    Get.put(ServicesController());
    final image =
        NetworkImage('${ServerRoutes.host}/avatar?path=avatar_${item['uid']}');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        width: MediaQuery.of(context).size.width - 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              order == true
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: GestureDetector(
                        onTap: () async {
                          final userModel = Provider.of<GetUserProfile>(context,
                              listen: false);
                          final user =
                              await userModel.getOtherUserProfile(item['uid']);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OtherFreelancerProfileView(
                                        thisUid: item['uid'],
                                        userModel: user,
                                      )));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            //   color: Colors.grey.shade300,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: CircleAvatar(
                                  backgroundColor: Colors.white.withOpacity(0),
                                  radius: 23,
                                  backgroundImage: image,
                                  // AssetImage('assets/dwd_logo.jpeg'),
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['freelancer_name'],
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        item['freelancer_rating'],
                                        style: GoogleFonts.inter(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xffF9CF3A)),
                                      ),
                                      SvgPicture.asset(
                                        'assets/design/images/mini_star.svg',
                                        color: const Color(0xffF9CF3A),
                                      ),
                                      Text(
                                        '5 отзывов',
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
                    )
                  : const SizedBox(),
              Text(
                '${item['name']} (${item['category_name']})',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                item['description'].length < 131
                    ? upperfirst(item['description'])
                    : '${upperfirst(item['description']).substring(0, 130)}...',
                style: GoogleFonts.inter(),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          item['monday'] == '1' ? const Text('Пн,') : const SizedBox(),
                          item['tuesday'] == '1' ? const Text('Вт,') : const SizedBox(),
                          item['wednesday'] == '1'
                              ? const Text('Ср,')
                              : const SizedBox(),
                          item['thursday'] == '1'
                              ? const Text('Чт,')
                              : const SizedBox(),
                          item['friday'] == '1' ? const Text('Пт,') : const SizedBox(),
                          item['saturday'] == '1'
                              ? const Text('Сб,')
                              : const SizedBox(),
                          item['sunday'] == '1' ? const Text('Вс') : const SizedBox(),
                        ],
                      ),
                      item['time'].toString().length > 3
                          ? Text(
                          '${item['time'].toString().substring(0, 2)}:00-${item['time'].toString().substring(2, 4)}:00')
                          : const Text('Нет рабочего графика'),
                      Text(
                        '${item['fixPrice'] == '0' && item['hourPrice'] == '1' ? 'От ${item['price_min']}€ в час' : item['fixPrice'] == '0' ? 'От ${item['price_min']}€' : item['hourPrice'] == '1' ? '${item['price_min']}€ в час' : item['price_min']}',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
           my == true ?  archive == false ?     IconButton(onPressed: (){
                    controller.archiveService(item['id']);
                  }, icon: const Icon(Icons.delete,color: Colors.red,)) :   IconButton(onPressed: (){
               controller.activateService(item['id']);
             }, icon: const Icon(Icons.backup_sharp ,color: Colors.green,)) : SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
