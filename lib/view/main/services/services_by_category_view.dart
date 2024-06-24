import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../../ServerRoutes.dart';
import '../../../../../domain/user/get_user_profile.dart';
import '../../../controller/services_controller.dart';
import '../../no_login/no_login_home.dart';
import '../../no_login/no_login_services.dart';
import '../profile/other_profile/other_freelancer_profile_view.dart';

class AllServicesByCategoryView extends GetView<ServicesController> {
  final categoryName;
  const AllServicesByCategoryView({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    Get.put(ServicesController());
    controller.getCategoryServices(categoryName);
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xffFAFAFA),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Obx(
          () => controller.servicesByCategory.isNotEmpty
              ? ListView(
                  children: List.generate(controller.servicesByCategory.length,
                      (index) {
                    final item = controller.servicesByCategory[index];
                    return NewServiceCardWidget(
                      item: item,
                      order: false,
                    );
                  }),
                )
              : const Center(
                  child: Text('В данной категорий пока нет услуг'),
                ),
        ),
      ),
    );
  }
}

class ServiceCardWidget extends StatelessWidget {
  final item;
  final bool order;
  const ServiceCardWidget({super.key, required this.item, required this.order});

  @override
  Widget build(BuildContext context) {
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
                              Text(
                                item['freelancer_name'],
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
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
              Text(
                  '${item['time'].toString().substring(0, 2)}:00-${item['time'].toString().substring(2, 4)}:00'),
              Text(
                '${item['fixPrice'] == '0' && item['hourPrice'] == '1' ? 'От ${item['price_min']} в час' : item['fixPrice'] == '0' ? 'От ${item['price_min']}' : item['hourPrice'] == '1' ? '${item['price_min']} в час' : item['price_min']}€',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
