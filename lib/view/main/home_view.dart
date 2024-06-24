// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newlensfront/view/main/profile/my_profile/my_orders_view.dart';
import 'package:newlensfront/view/main/response_order_view.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../ServerRoutes.dart';
import '../../controller/order_controller.dart';
import '../../domain/order/add_order_see.dart';
import '../../domain/order/get_order_from_id.dart';
import '../../domain/user/auth/create_user.dart';
import '../../domain/user/get_user_profile.dart';
import '../../main.dart';
import '../order/work_orders_list_view.dart';
import '../widgets/draver_widget.dart';
import '../widgets/order_card_widget.dart';
import '../widgets/service_widget.dart';
import 'last_orders_view.dart';
import 'new_masters_view.dart';
import 'services/services_by_category_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final testModel = context.read<GetOrderFromId>();
    final controller = TextEditingController();
    final orderController = Get.put(OrderController());
    final profileModel = context.watch<GetUserProfile>();
    final image = NetworkImage('${ServerRoutes.host}/avatar?path=avatar_$uid');
    profileModel.getUserProfile(int.parse(uid));
    orderController.getMyActiveOrders(uid);
    orderController.getAllOrders('');
    orderController.getWorkOrders(uid);
    return Obx(
      () => Scaffold(
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
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  // launchUrl(Uri.parse(
                                  //     'https://www.instagram.com/profe_io?igsh=MW5vcnp3OXUzMzJycA=='));
                                },
                                child: SvgPicture.asset(
                                  'assets/svg/Instagram_logo_2016.svg',
                                  height: 24,
                                  width: 22,
                                )),
                            const SizedBox(
                              width: 8,
                            ),
                            // const Icon(
                            //   CupertinoIcons.heart_fill,
                            //   color: Colors.red,
                            // ),
                            // const SizedBox(
                            //   width: 8,
                            // ),
                            // const Icon(CupertinoIcons.bell)
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    orderController.workOrders.isNotEmpty
                        ? const SizedBox(
                            height: 16,
                          )
                        : const SizedBox(),
                    orderController.workOrders.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (controller) =>
                                          const WorkOrdersListView()));
                            },
                            child: Container(
                              height: 52,
                              width: MediaQuery.of(context).size.width - 32,
                              decoration: BoxDecoration(
                                color: const Color(0xffFFFFFF),
                                borderRadius: BorderRadius.circular(14),
                                border:
                                    Border.all(color: const Color(0xffF14F44)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Заказы в работе',
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
                                          orderController.workOrders.length
                                              .toString(),
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
                        : const SizedBox(),
                    const SizedBox(
                      height: 16,
                    ),

                    orderController.myActiveOrders.value.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (controller) =>
                                          const MyOrdersView()));
                            },
                            child: Container(
                              height: 52,
                              width: MediaQuery.of(context).size.width - 32,
                              decoration: BoxDecoration(
                                color: const Color(0xffFFFFFF),
                                borderRadius: BorderRadius.circular(14),
                                border:
                                    Border.all(color: const Color(0xffF14F44)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Мои заявки',
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
                                          orderController
                                              .myActiveOrders.value.length
                                              .toString(),
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
                        : const SizedBox(),
                    orderController.myActiveOrders.value.isNotEmpty
                        ? const SizedBox(
                            height: 24,
                          )
                        : const SizedBox(),
                    // Text(
                    //   translateController.popular,
                    //   style: GoogleFonts.inter(
                    //       fontSize: 20, fontWeight: FontWeight.w500),
                    // ),
                    const SizedBox(
                      height: 12,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AllServicesByCategoryView(
                                              categoryName:
                                                  'Свадебные фотосессии',
                                            )));
                              },
                              child: ServicesWidget(
                                name:
                                 'Свадебные фотосессии',
                                image: 'image/builder.png',
                                color: const Color.fromRGBO(223, 248, 255, 1),
                                width: MediaQuery.of(context).size.width * 0.44,
                                height: 72,
                                sizew: 60,
                                sizeh: 60,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            // const OrdersFromCatView(
                                            //   categoryName: 'Красота и здоровье',
                                            //   category: 17,
                                            // )
                                            const AllServicesByCategoryView(
                                              categoryName:
                                                  'Обработка фото',
                                            )));
                              },
                              child: ServicesWidget(
                                name:  'Обработка фото',
                                image: 'image/beat.png',
                                color: const Color.fromRGBO(253, 237, 239, 1),
                                width: MediaQuery.of(context).size.width * 0.44,
                                height: 72,
                                sizew: 90,
                                sizeh: 90,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AllServicesByCategoryView(
                                              categoryName: 'Фото на природе',
                                            )));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.28,
                                height: 72,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(255, 242, 208, 1),
                                    borderRadius: BorderRadius.circular(14)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 6.0, left: 6),
                                  child: Stack(children: [
                                    Image.asset(
                                      "image/Img.png",
                                      width: 110,
                                      height: 110,
                                      alignment: Alignment.bottomCenter,
                                    ),
                                    Text(
                                      "Фото на природе",
                                      style: GoogleFonts.inter(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AllServicesByCategoryView(
                                              categoryName:
                                                  'Фотограф в штат',
                                            )));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.28,
                                height: 72,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(221, 251, 228, 1),
                                    borderRadius: BorderRadius.circular(14)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8.0, left: 8),
                                  child: Stack(children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Image.asset(
                                        "image/computer.png",
                                        width: 72,
                                        height: 72,
                                        alignment: Alignment.bottomCenter,
                                      ),
                                    ),
                                    Text(
                                      "Стилисты",
                                      style: GoogleFonts.inter(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AllServicesByCategoryView(
                                              categoryName:
                                                  'Визажисты',
                                            )));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.28,
                                height: 72,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(255, 216, 199, 1),
                                    borderRadius: BorderRadius.circular(14)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8.0, left: 8),
                                  child: Stack(children: [

                                    Text(
                                      "Визажисты",
                                      style: GoogleFonts.inter(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          translateController.Recent_applications,
                          style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LastOrdersView()));
                            },
                            child: Text(translateController.All_applications)),
                      ],
                    ),
                    SizedBox(
                      height: 193,
                      width: double.infinity,
                      child: ListView.builder(
                        itemCount: orderController.allOrders.value.length,
                        itemBuilder: (context, index) {
                          final item = orderController.allOrders.value[index];
                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () async {
                                  addOrderSee(item.id);
                                  await testModel.getOrderFromId(index);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ResponseOrderView(
                                                lat: item.lat,
                                                long: item.long,
                                                images: item.images,
                                                dateStart: item.dateAndTime,
                                                item: item,
                                                ccid: item.ccid,
                                                freelancer: profileModel
                                                    .userModel?.freelancer
                                                    .toString(),
                                                uid: item.uid,
                                                id: int.parse(item.id),
                                                name: item.name,
                                                address: item.address,
                                                city: item.city,
                                                category: item.category,
                                                sees: item.sees,
                                                description: item.description,
                                                wishes: item.wishes,
                                                orderStatus: item.orderStatus,
                                              )));
                                },
                                child: OrderCardWidget(
                                    item: item,
                                    myOrders: false,
                                    profileModel: profileModel),
                              ));
                        },
                      ),
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

String upperfirst(String text) {
  if (text.isEmpty) return text;
  return '${text[0].toUpperCase()}${text.substring(1)}';
}
