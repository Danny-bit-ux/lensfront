import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/top_row_widget.dart';
import 'create_order_set_price_view.dart';

bool remotely = false;
double latitude = 0.0;
double longitude = 0.0;
TextEditingController orderAddressController = TextEditingController();
List addressList = [];

class CreateOrderSetAdressView extends StatefulWidget {
  final String orderName;
  final String dateAndTime;
  final String categoryName;
  final String description;
  final String parentCategoryId;
  final String categoryId;
  const CreateOrderSetAdressView(
      {super.key,
      required this.categoryName,
      required this.orderName,
      required this.parentCategoryId,
      required this.categoryId,
      required this.dateAndTime,
      required this.description});

  @override
  State<CreateOrderSetAdressView> createState() =>
      _CreateOrderSetAdressViewState();
}

class _CreateOrderSetAdressViewState extends State<CreateOrderSetAdressView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopRowWidget(text: 'Шаг 4 из 7'),
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
              Text(
                'Где нужно?',
                style: GoogleFonts.abel(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: orderAddressController,
                onChanged: (_) async {
                  Dio dio = Dio();
                  if (orderAddressController.text.length > 10) {
                    final response = await dio.get(
                      'https://api.mapbox.com/search/geocode/v6/forward?q=${orderAddressController.text}&proximity=ip&access_token=pk.eyJ1Ijoidml0MDYiLCJhIjoiY2x2NTJna2NwMDQzYzJqczFuanVxY2hlaiJ9.UoXuy80PaSShDmvMXx2goQ',
                    );
                    setState(() {
                      addressList = response.data['features'];
                    });
                  }
                },
                decoration: InputDecoration(
                  hintStyle: GoogleFonts.inter(
                    color: const Color(
                      0xFFCBCBCB,
                    ),
                  ),
                  hintText: 'Город, дом, улица',
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                    addressList.length,
                    (index) => GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(addressList[index]['properties']
                                    ['full_address']
                                .toString()),
                          ),
                          onTap: () {
                            orderAddressController.text = addressList[index]
                                    ['properties']['full_address']
                                .toString();
                            latitude = addressList[index]
                                ['geometry']['coordinates'][0];
                            longitude = addressList[index]
                                ['geometry']['coordinates'][1];
                          },
                        )),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        remotely = !remotely;
                        setState(() {});
                      },
                      child: remotely == false
                          ? Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xff808080)),
                                borderRadius: BorderRadius.circular(120),
                              ),
                            )
                          : Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xff808080)),
                                borderRadius: BorderRadius.circular(120),
                              ),
                              child: const CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 5,
                              ),
                            )),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Можно выполнить удалённо',
                    style: GoogleFonts.abel(
                      color: const Color(0xff808080),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 45.0, right: 10, left: 10),
        child: GestureDetector(
          onTap: () {
            orderAddressController.text.isEmpty && remotely == false
                ? null
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateOrderSetPriceView(
                              latitude: latitude,
                              longitude: longitude,
                              parentCategoryId: widget.parentCategoryId,
                              categoryId: widget.categoryId,
                              remotely: remotely,
                              categoryName: widget.categoryName,
                              orderName: widget.orderName,
                              address: orderAddressController.text,
                              dateAndTime: widget.dateAndTime,
                              description: widget.description,
                            )));
          },
          child: Container(
            height: 52,
            width: MediaQuery.of(context).size.width - 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: orderAddressController.text.isEmpty && remotely == false
                  ? const Color(0xffEBEBEB)
                  : const Color(0xffF14F44),
            ),
            child: Center(
              child: Text('Продолжить',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: orderAddressController.text.isEmpty && remotely == false
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
