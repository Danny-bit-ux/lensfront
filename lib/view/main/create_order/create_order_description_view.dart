
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/top_row_widget.dart';
import 'create_order_set_time_view.dart';

FocusNode _focusNode = FocusNode();
TextEditingController orderDescriptionController = TextEditingController();

class CreateOrderDescription extends StatefulWidget {

  final String orderName;
  final String categoryName;
  final String categoryId;
  final String parentCategoryId;
  const CreateOrderDescription(
      {super.key,
        required this.categoryName,
        required this.parentCategoryId,
        required this.categoryId,
        required this.orderName,
   });

  @override
  State<CreateOrderDescription> createState() =>
      _CreateOrderOtherPropiretiesViewState();
}

class _CreateOrderOtherPropiretiesViewState
    extends State<CreateOrderDescription> {
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
                  const TopRowWidget(text: 'Шаг 3 из 7'),
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
                      setState(() {
                      });
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
                      builder: (context) => CreateOrderSetTimeView(
                        parentCategoryId: widget.parentCategoryId,
                        categoryId: widget.categoryId,
                        description: orderDescriptionController.text,
                        categoryName: widget.categoryName,
                        orderName: widget.orderName,
                      )));
            },
            child: Container(
              height: 52,
              width: MediaQuery.of(context).size.width - 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: orderDescriptionController.text.isEmpty ? const Color(0xffEBEBEB) : const Color(0xffF14F44),
              ),
              child: Center(
                child: Text('Продолжить',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color:orderDescriptionController.text.isEmpty ? Colors.black : Colors.white,
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }

}
