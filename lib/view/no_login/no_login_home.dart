// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newlensfront/view/main/map_view.dart';
import 'package:provider/provider.dart';

import '../../controller/order_controller.dart';
import '../../domain/order/add_order_see.dart';
import '../../domain/order/get_order_from_id.dart';
import '../../domain/user/get_user_profile.dart';
import '../../main.dart';
import '../main/all_categories.dart';
import '../main/last_orders_view.dart';
import '../main/orders_from_cat_view.dart';
import '../main/response_order_view.dart';
import '../widgets/arenda_prodaja_card.dart';
import '../widgets/draver_widget.dart';
import '../widgets/order_card_widget.dart';
import '../widgets/service_widget.dart';
import 'no_login_alert.dart';

class NoLoginHomeScreen extends StatefulWidget {
  const NoLoginHomeScreen({super.key});

  @override
  State<NoLoginHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<NoLoginHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final testModel = context.read<GetOrderFromId>();
    final controller = TextEditingController();
    final orderController = Get.put(OrderController());
    final profileModel = context.watch<GetUserProfile>();
    orderController.getAllOrders('');
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
                          //  backgroundImage: image,
                          child: Builder(builder: (context) {
                            return IconButton(
                              onPressed: () {
                                showDialog<void>(
                                    useSafeArea: false,
                                    context: context,
                                    barrierDismissible:
                                        true, // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: const Color(0xff2D2D2D)
                                            .withOpacity(0),
                                        contentPadding: EdgeInsets.zero,
                                        insetPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12),
                                        content: const NoLoginAlert(),
                                      );
                                    });
                                //  Scaffold.of(context).openDrawer();
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
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12)),
                          child: MaterialButton(
                            onPressed: () {
                              showDialog<void>(
                                  useSafeArea: false,
                                  context: context,
                                  barrierDismissible:
                                      true, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: const Color(0xff2D2D2D)
                                          .withOpacity(0),
                                      contentPadding: EdgeInsets.zero,
                                      insetPadding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      content: const NoLoginAlert(),
                                    );
                                  });
                            },
                            child: Center(
                              child: Text(
                                "Создать",
                                softWrap: false,
                                style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        )
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
                                controller: controller,
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
                              setState(() {});
                            },
                            icon: const Icon(Icons.refresh)),
                      ],
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
                                            const OrdersFromCatView(
                                              categoryName: 51,
                                              category:
                                                  'Ремонт и строительство',
                                            )));
                              },
                              child: ServicesWidget(
                                name:
                                    translateController.Repair_and_construction,
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
                                            const OrdersFromCatView(
                                              categoryName: 17,
                                              category: 'Красота и здоровье',
                                            )));
                              },
                              child: ServicesWidget(
                                name: translateController.Beauty_and_wellness,
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
                            Container(
                              width: MediaQuery.of(context).size.width * 0.28,
                              height: 72,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(255, 242, 208, 1),
                                  borderRadius: BorderRadius.circular(14)),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const OrdersFromCatView(
                                                categoryName: 63,
                                                category: 'Бытовые услуги',
                                              )));
                                },
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
                                      "Бытовые\nуслуги",
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
                            Container(
                              width: MediaQuery.of(context).size.width * 0.28,
                              height: 72,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(221, 251, 228, 1),
                                  borderRadius: BorderRadius.circular(14)),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const OrdersFromCatView(
                                                categoryName: 38,
                                                category: 'Консультация',
                                              )));
                                },
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
                                      "Консультация",
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
                            Container(
                              width: MediaQuery.of(context).size.width * 0.28,
                              height: 72,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(255, 216, 199, 1),
                                  borderRadius: BorderRadius.circular(14)),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const OrdersFromCatView(
                                                categoryName: 7,
                                                category: 'Перевозки',
                                              )));
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8.0, left: 8),
                                  child: Stack(children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Image.asset(
                                        "image/Van.png",
                                        width: 72,
                                        height: 72,
                                        alignment: Alignment.bottomCenter,
                                      ),
                                    ),
                                    Text(
                                      "Перевозки",
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
                        const SizedBox(
                          height: 10,
                        ),
                        const ArendaProdajaCardWidget(),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AllCategoriesView(
                                      services: false,
                                    )));
                      },
                      child: Container(
                        width: 55,
                        height: 22,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(46)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                translateController.more,
                                style: GoogleFonts.inter(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              const Icon(
                                Icons.keyboard_arrow_right,
                                size: 12,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Смотреть на карте",
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
                                      builder: (context) => const MapView()));
                            },
                            child: Icon(Icons.map_rounded)),
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
