// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../../controller/fill_adverb_controller.dart';
import '../../../../domain/ads/create_adverb.dart';
import '../../../../domain/user/auth/create_user.dart';
import '../../../main_view.dart';
import '../../../widgets/custom_textfield_widget.dart';

final ImagePicker imagePicker = ImagePicker();
List<XFile> _imageFileList = [];
FocusNode _focusNode = FocusNode();

TextEditingController _descriptionController = TextEditingController();
TextEditingController _priceController = TextEditingController();
TextEditingController _addressController = TextEditingController();
bool _phone = true;
bool _messages = true;

class CreateAdverbDescriptionView extends StatefulWidget {
  final String categoryName;
  final viewmodel;
  final name;
  final type;
   const CreateAdverbDescriptionView(
      {super.key, required this.categoryName,  required this.viewmodel,required this.name,required this.type});

  @override
  State<CreateAdverbDescriptionView> createState() =>
      _CreateAdverbDescriptionViewState();
}

class _CreateAdverbDescriptionViewState
    extends State<CreateAdverbDescriptionView> {
  @override
  Widget build(BuildContext context) {
    final adverbModel = context.read<FillAdverbModel>();
    final createAdverb = context.read<CreateAdverb>();
    adverbModel.adverbModel.uid = uid;
    adverbModel.adverbModel.category = widget.categoryName;
    adverbModel.adverbModel.messages = true;
    adverbModel.adverbModel.phone = false;
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Внешний вид'),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.categoryName,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: const Color(0xff808080),
                  ),
                ),
                 Text(
                  'Опишите товар',
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  onChanged: (_) {
                    adverbModel.adverbModel.description = _descriptionController.text;
                  },
                  focusNode: _focusNode,
                  maxLines: 10,
                  minLines: 5,
                  maxLength: 1000,
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                      color: Color(
                        0xFFCBCBCB,
                      ),
                    ),
                    hintText: 'Описание',
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
                  height: 16,
                ),
                const Text(
                  'Цена',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextFieldWidget(
                  onChange: (_) {
                    adverbModel.adverbModel.price = _priceController.text;
                  },
                    controller: _priceController,
                    text: 'Цена',
                    password: false),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Адрес',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextFieldWidget(
                    onChange: (_) {
                      adverbModel.adverbModel.address = _addressController.text;
                    },
                    controller: _addressController,
                    text: 'Адрес',
                    password: false),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Тип связи',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Checkbox(
                        value: _phone,
                        onChanged: (value) {
                          _phone = !_phone;
                          adverbModel.adverbModel.phone = _phone;
                          setState(() {});
                        }),
                    const Text(
                      'По телефону',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff808080),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                        value: _messages,
                        onChanged: (value) {
                          _messages = !_messages;
                          adverbModel.adverbModel.messages = _messages;
                          setState(() {});
                        }),
                    const Text(
                      'Сообщения',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff808080),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                 widget.viewmodel ?? const SizedBox(),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () {
                    adverbModel.adverbModel.timestamp = DateTime.now();
                    adverbModel.adverbModel.type = widget.type;
                    adverbModel.adverbModel.name = widget.name;
                    createAdverb.createAdverb(adverbModel.adverbModel, _imageFileList);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MainView()));
                   print( adverbModel.adverbModel);
                    showDialog<void>(
                      context: context,
                      barrierDismissible:
                      false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            'Ваше объявление создано!',
                            textAlign: TextAlign.center,
                          ),
                          content: const SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text(
                                  'Теперь пользователи его увидят!',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                           GestureDetector(
                             onTap: () {
                               Navigator.pop(context);
                             },
                             child: Container(
                               height: 52,
                               width: MediaQuery.of(context).size.width -32,
                               decoration: BoxDecoration(
                                 color: Colors.red,
                                 borderRadius: BorderRadius.circular(8),
                               ),
                               child: const Center(
                                 child: Text('Закрыть',
                                 style: TextStyle(
                                   fontSize: 16,
                                   color: Colors.white,
                                 ),),
                               ),
                             ),
                           )
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 52,
                    width: MediaQuery.of(context).size.width - 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xffF14F44),
                    ),
                    child: const Center(
                      child: Text('Создать',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
  Future<void> _pickImages() async {
    final picker = ImagePicker();
    List<XFile> pickedImages = await picker.pickMultiImage(imageQuality: 15);
    setState(() {
      _imageFileList = pickedImages;
    });
  }
}
