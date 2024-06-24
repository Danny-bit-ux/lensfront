import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import '../../../controller/order_controller.dart';
import '../../widgets/top_row_widget.dart';
import 'create_order_set_name.dart';

class CreateOrderSelectCategory extends GetView<OrderController> {
  const CreateOrderSelectCategory({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderController());
    controller.getCategoriesList();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TopRowWidget(text: 'Создание заявки'),
                8.heightBox,
                Obx(
                      () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    List.generate(controller.categories.length, (index) {
                      final item = controller.categories[index];
                      List pods = item['pods'];
                      return pods.isNotEmpty
                          ? ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        title: Text(
                          item['category'],
                          style: GoogleFonts.inter(
                            fontSize: 14,
                          ),
                        ),
                        children: List.generate(
                            pods.length,
                                (ind) => Container(
                                alignment: Alignment.centerLeft,
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4),
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateOrderSetName(categoryName: pods[ind]['category'],categoryId: pods[ind]['id'].toString(),parentCategoryId: item['id'].toString(),)));
                                      },
                                      child: Text(pods[ind]['category'])),
                                ))),
                      )
                          : Container(
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateOrderSetName(categoryName: item['category'],categoryId: item['id'].toString(),parentCategoryId: item['id'].toString(),)));
                              },
                              child: Text(item['category']),
                            ),
                          ));
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
   //  Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateOrderSetName(categoryName: pods[ind]['category'],categoryId: pods[ind]['id'].toString(),parentCategoryId: item['id'].toString(),)));
//