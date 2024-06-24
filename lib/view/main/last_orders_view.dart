// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newlensfront/view/main/response_order_view.dart';
import 'package:provider/provider.dart';
import '../../controller/order_controller.dart';
import '../../domain/order/add_order_see.dart';
import '../../domain/user/get_user_profile.dart';
import '../widgets/order_card_widget.dart';
TextEditingController _searchController = TextEditingController();
class LastOrdersView extends GetView<OrderController> {
  const LastOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderController());
    controller.getAllOrders(_searchController.text);
    final profileModel = context.watch<GetUserProfile>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Все заявки'),
        centerTitle: true,
      ),
      body: Obx(
        () => SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
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
                              onChanged: (v) {
                                controller
                                    .getAllOrders(_searchController.text);
                              },
                              controller: _searchController,
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
                            controller.getAllOrders(_searchController.text);
                          },
                          icon: const Icon(Icons.send)),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.allOrders.value.length,
                      itemBuilder: (context, index) {
                        final item = controller.allOrders.value[index];
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () async {
                                addOrderSee(item.id);
                                print('item $item');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ResponseOrderView(
                                              item: item,
                                              lat: item.lat,
                                              long: item.long,
                                              images: item.images,
                                              dateStart: item.dateAndTime,
                                              ccid: item.ccid,
                                              freelancer: profileModel
                                                  .userModel?.freelancer
                                                  .toString(),
                                              uid: item.uid,
                                              id: int.parse(item.id),
                                              name: item.name,
                                              address: null,
                                              city: item.city,
                                              category: item.category,
                                              sees: item.sees,
                                              description: 'ffddfihd',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
