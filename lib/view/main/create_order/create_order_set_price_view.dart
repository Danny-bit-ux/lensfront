import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/top_row_widget.dart';
import 'create_order_other_propitries_view.dart';

TextEditingController orderMinPriceController = TextEditingController();
TextEditingController orderMaxPriceController = TextEditingController();
TextEditingController orderFixPriceController = TextEditingController();
bool fix_price = false;
bool not_price = false;

class CreateOrderSetPriceView extends StatefulWidget {
  final String categoryName;
  final String orderName;
  final String dateAndTime;
  final String address;
  final String description;
  final String parentCategoryId;
  final String categoryId;
  final bool remotely;
  final double latitude;
  final double longitude;
  const CreateOrderSetPriceView({
    super.key,
    required this.orderName,
    required this.categoryName,
    required this.dateAndTime,
    required this.address,
    required this.remotely,
    required this.categoryId,
    required this.parentCategoryId,
    required this.description,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<CreateOrderSetPriceView> createState() =>
      _CreateOrderSetPriceViewState();
}

class _CreateOrderSetPriceViewState extends State<CreateOrderSetPriceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TopRowWidget(
                  text: 'Шаг 5 из 7',
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  widget.categoryName,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xff808080),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 45.0, right: 10, left: 10),
        child: GestureDetector(
          onTap: () {
            if (not_price == false &&
                fix_price == false &&
                orderMinPriceController.text.isNotEmpty &&
                orderMaxPriceController.text.isNotEmpty) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateOrderOtherPropiretiesView(
                            parentCategoryId: widget.parentCategoryId,
                            categoryId: widget.categoryId,
                            categoryName: widget.categoryName,
                            notPrice: not_price,
                            fixPrice: fix_price,
                            orderName: widget.orderName,
                            priceMax: orderMaxPriceController.text,
                            dateAndTime: widget.dateAndTime,
                            address: widget.address,
                            priceMin: orderMinPriceController.text,
                            remotely: widget.remotely,
                            longitude: widget.longitude,
                            latitude: widget.latitude,
                            description: widget.description,
                          )));
            } else if (not_price == false &&
                fix_price == true &&
                orderMinPriceController.text.isNotEmpty) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateOrderOtherPropiretiesView(
                            parentCategoryId: widget.parentCategoryId,
                            categoryId: widget.categoryId,
                            fixPrice: fix_price,
                            notPrice: not_price,
                            categoryName: widget.categoryName,
                            orderName: widget.orderName,
                            priceMax: orderMaxPriceController.text,
                            dateAndTime: widget.dateAndTime,
                            address: widget.address,
                            priceMin: orderMinPriceController.text,
                            remotely: widget.remotely,
                            longitude: widget.longitude,
                            latitude: widget.latitude,
                            description: widget.description,
                          )));
            } else if (not_price == true) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateOrderOtherPropiretiesView(
                            parentCategoryId: widget.parentCategoryId,
                            fixPrice: fix_price,
                            notPrice: not_price,
                            categoryId: widget.categoryId,
                            categoryName: widget.categoryName,
                            orderName: widget.orderName,
                            priceMax: orderMaxPriceController.text,
                            dateAndTime: widget.dateAndTime,
                            address: widget.address,
                            priceMin: orderMinPriceController.text,
                            remotely: widget.remotely,
                            longitude: widget.longitude,
                            latitude: widget.latitude,
                            description: widget.description,
                          )));
            }
          },
          child: Container(
            height: 52,
            width: MediaQuery.of(context).size.width - 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: not_price == false
                  ? fix_price == false
                      ? orderMinPriceController.text.isEmpty ||
                  orderMaxPriceController.text.isEmpty
                          ? const Color(0xffEBEBEB)
                          : const Color(0xffF14F44)
                      : orderFixPriceController.text.isEmpty
                          ? const Color(0xffEBEBEB)
                          : const Color(0xffF14F44)
                  : const Color(0xffF14F44),
            ),
            child: Center(
              child: Text('Продолжить',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: orderMinPriceController.text.isEmpty ||
                        orderMaxPriceController.text.isEmpty
                        ? Colors.black
                        : Colors.white,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
