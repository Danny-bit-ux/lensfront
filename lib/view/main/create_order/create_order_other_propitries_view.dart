import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/top_row_widget.dart';
import 'create_order_set_name_view.dart';

FocusNode _focusNode = FocusNode();
TextEditingController orderSupEditingController = TextEditingController();

final ImagePicker imagePicker = ImagePicker();
List<XFile> _imageFileList = [];
class CreateOrderOtherPropiretiesView extends StatefulWidget {
  final String categoryName;
  final String orderName;
  final String dateAndTime;
  final String address;
  final String priceMin;
  final bool fixPrice;
  final bool notPrice;
  final String description;
  final String priceMax;
  final bool remotely;
  final String categoryId;
  final String parentCategoryId;
  final double latitude;
  final  double longitude;
  const CreateOrderOtherPropiretiesView(
      {super.key,
      required this.categoryName,
      required this.parentCategoryId,
      required this.categoryId,
      required this.dateAndTime,
      required this.orderName,
      required this.address,
      required this.priceMax,
      required this.priceMin,
      required this.remotely,
        required this.fixPrice,
        required this.notPrice,
        required this.description,
        required this.latitude,
        required this.longitude
      });

  @override
  State<CreateOrderOtherPropiretiesView> createState() =>
      _CreateOrderOtherPropiretiesViewState();
}

class _CreateOrderOtherPropiretiesViewState
    extends State<CreateOrderOtherPropiretiesView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TopRowWidget(text: 'Шаг 6 из 7'),
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
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return index != 0
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Image.file(
                                                File(_imageFileList[index - 1]
                                                    .path),
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
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 45.0, right: 10,left: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateOrderSetNameAndEmailView(
                        fixPrice: widget.fixPrice,
                            photos: _imageFileList,
                            notPrice: widget.notPrice,
                            parentCategoryId: widget.parentCategoryId,
                            categoryId: widget.categoryId,
                            categoryName: widget.categoryName,
                            remotely: widget.remotely,
                            orderName: widget.orderName,
                            priceMax: widget.priceMax,
                            priceMin: widget.priceMin,
                            address: widget.address,
                            dateAndTime: widget.dateAndTime,
                            description: widget.description,
                            sup: orderSupEditingController.text,
                        longitude: widget.longitude,
                        latitude: widget.latitude,
                          )));
            },
            child: Container(
              height: 52,
              width: MediaQuery.of(context).size.width - 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xffF14F44),
              ),
              child: Center(
                child: Text('Продолжить',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
                    )),
              ),
            ),
          ),
        ),

      ),
    );
  }
  Future<void> _pickImages() async {
    final picker = ImagePicker();
    List<XFile> pickedImages = await picker.pickMultiImage(imageQuality: 35);
    setState(() {
      _imageFileList = pickedImages;
    });
  }
}
