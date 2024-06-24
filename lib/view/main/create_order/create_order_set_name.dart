import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newlensfront/controller/order_controller.dart';
import 'package:provider/provider.dart';
import '../../../domain/user/auth/create_user.dart';
import '../../../domain/user/get_user_profile.dart';
import '../../main_view.dart';
import '../../widgets/custom_textfield_widget.dart';
import '../../widgets/top_row_widget.dart';
import 'create_order_description_view.dart';

TextEditingController orderNameController = TextEditingController();
FocusNode _focusNode = FocusNode();
TextEditingController orderDescriptionController = TextEditingController();
TextEditingController _nameController = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController orderMinPriceController = TextEditingController();
TextEditingController orderMaxPriceController = TextEditingController();
TextEditingController orderFixPriceController = TextEditingController();
TextEditingController orderTimeController = TextEditingController();
TextEditingController orderSupEditingController = TextEditingController();

final ImagePicker imagePicker = ImagePicker();
List<XFile> _imageFileList = [];

bool remotely = false;
double latitude = 0.0;
double longitude = 0.0;
TextEditingController orderAddressController = TextEditingController();
List addressList = [];
bool fix_price = false;
bool not_price = false;

class CreateOrderSetName extends StatefulWidget {
  final String categoryName;
  final String categoryId;
  final String parentCategoryId;
  const CreateOrderSetName(
      {super.key,
      required this.categoryId,
      required this.categoryName,
      required this.parentCategoryId});

  @override
  State<CreateOrderSetName> createState() => _CreateOrderSetNameState();
}

class _CreateOrderSetNameState extends State<CreateOrderSetName> {
  @override
  Widget build(BuildContext context) {
  final controller = Get.put(OrderController());
    final userData = context.read<GetUserProfile>();
    _emailController.text = userData.userModel!.email;
    _nameController.text = userData.userModel!.name;
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopRowWidget(text: 'Название заявки'),
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
            const Text(
              'Как будет называться заявка?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            CustomTextFieldWidget(
              controller: orderNameController,
              text: 'Введите название заявки',
              password: false,
              onChange: (_) {
                setState(() {});
              },
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              'Описание заказа',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (_) {
                setState(() {});
              },
              focusNode: _focusNode,
              maxLines: 10,
              minLines: 5,
              maxLength: 1000,
              controller: orderDescriptionController,
              decoration: InputDecoration(
                hintStyle: const TextStyle(
                  color: Color(
                    0xFFCBCBCB,
                  ),
                ),
                hintText: 'Напишите важные детали для специалиста',
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
            const SizedBox(
              height: 12,
            ),
            const Text(
              'Сколько готовы заплатить?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            not_price == false
                ? fix_price == false
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2 - 26,
                            child: TextField(
                              controller: orderMinPriceController,
                              keyboardType: TextInputType.number,
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
                              onChanged: (_) {
                                setState(() {});
                              },
                              keyboardType: TextInputType.number,
                              controller: orderMaxPriceController,
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
                      )
                    : TextField(
                        onChanged: (_) {
                          setState(() {});
                        },
                        controller: orderMinPriceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(
                            color: Color(
                              0xFFCBCBCB,
                            ),
                          ),
                          hintText: 'Цена €',
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
                      )
                : const SizedBox(),
            const SizedBox(
              height: 24,
            ),
            Row(
              children: [
                CupertinoSwitch(
                    value: not_price,
                    onChanged: (_) {
                      not_price = !not_price;
                      setState(() {});
                    }),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  'Договорная цена',
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
            not_price == false
                ? Row(
                    children: [
                      CupertinoSwitch(
                          value: fix_price,
                          onChanged: (_) {
                            fix_price = !fix_price;
                            setState(() {});
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
                  )
                : const SizedBox(),
            const SizedBox(
              height: 10,
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
                          latitude =
                              addressList[index]['geometry']['coordinates'][0];
                          longitude =
                              addressList[index]['geometry']['coordinates'][1];
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
              height: 12,
            ),
            const Text(
              'Когда нужно?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () {
                DatePicker.showDatePicker(
                  context,
                  pickerMode: DateTimePickerMode.datetime,
                  initialDateTime: DateTime.now().add(const Duration(days: 1)),
                  minDateTime: DateTime.now(),
                  maxDateTime: DateTime.now().add(const Duration(days: 365)),
                  locale: DateTimePickerLocale.en_us,
                  dateFormat: "dd MMMM yyyy",
                  onChange: (dateTime, selectedIndex) {
                    orderTimeController.text =
                        dateTime.toString().substring(0, 16);
                    setState(() {});
                  },
                  onConfirm: (dateTime, selectedIndex) {
                    orderTimeController.text =
                        dateTime.toString().substring(0, 16);
                  },
                );
              },
              child: TextField(
                onChanged: (_) {
                  setState(() {});
                },
                controller: orderTimeController,
                enabled: false,
                decoration: InputDecoration(
                  hintStyle: const TextStyle(
                    color: Color(
                      0xFFCBCBCB,
                    ),
                  ),
                  hintText: 'Дата',
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
            const SizedBox(
              height: 12,
            ),
            const Text(
              'Остались пожелания к\nзаказу?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              focusNode: _focusNode,
              maxLines: 10,
              minLines: 5,
              maxLength: 1000,
              controller: orderSupEditingController,
              decoration: InputDecoration(
                hintStyle: const TextStyle(
                  color: Color(
                    0xFFCBCBCB,
                  ),
                ),
                hintText: 'Напишите важные детали для специалиста',
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
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                              itemCount: _imageFileList.length + 1,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                              itemBuilder: (BuildContext context, int index) {
                                return index != 0
                                    ? Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Image.file(
                                          File(_imageFileList[index - 1].path),
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          _pickImages();
                                          setState(() {});
                                        },
                                        child: Image.asset(
                                            'assets/design/images/img.png'));
                              }))),
                  CustomTextFieldWidget(
                      controller: _nameController,
                      text: 'Введите имя',
                      password: false),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFieldWidget(
                      controller: _emailController,
                      text: 'Введите email',
                      password: false),
                ],
              ),
            ),
          ],
        ),
      ),
    )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 45.0, right: 10, left: 10),
        child: GestureDetector(
          onTap: () async {
            _emailController.text.isEmpty || _nameController.text.isEmpty
                ? null
                : await {
              controller.createOrder(
                  photos: _imageFileList,
                  address: orderAddressController.text,
                  description: orderDescriptionController.text,
                  not_price: not_price,
                  fix_price: fix_price,
                  categoryName: widget.categoryName,
                  uid: int.parse(uid),
                  name: orderNameController.text,
                  timestamp: DateTime.now().toString(),
                  categoryId: widget.categoryId,
                  category_sup: widget.categoryName,
                  date_and_time: orderTimeController.text,
                  geo_x: latitude.toString(),
                  geo_y: longitude.toString(),
                  geo_del_x: 0,
                  geo_del_y: 0,
                  price_min: orderMinPriceController.text.isEmpty ? null : orderMinPriceController.text,
                  price_max:orderMaxPriceController.text.isEmpty ? null : orderMaxPriceController.text,
                  wishes: orderSupEditingController.text,
                  username: _nameController.text,
                  order_status: 'active',
                  email: _emailController.text,
                  city: 'Moscow',
                  remotely: remotely),



              Future.delayed(const Duration(milliseconds: 100), () {
                controller.getMyActiveOrders(uid);
              }),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MainView()))
            };
          },
          child: Container(
            height: 52,
            width: MediaQuery.of(context).size.width - 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color:
              _emailController.text.isEmpty || _nameController.text.isEmpty
                  ? const Color(0xffEBEBEB)
                  : const Color(0xffF14F44),
            ),
            child: Center(
              child: Text('Создать',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: _emailController.text.isEmpty ||
                        _nameController.text.isEmpty
                        ? Colors.black
                        : Colors.white,
                  )),
            ),
          ),
        ),
      ),);
  }

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    List<XFile> pickedImages = await picker.pickMultiImage(imageQuality: 35);
    setState(() {
      _imageFileList = pickedImages;
    });
  }
}
