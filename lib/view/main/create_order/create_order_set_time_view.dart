import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/top_row_widget.dart';
import 'create_order_set_adress.dart';

TextEditingController orderTimeController = TextEditingController();

class CreateOrderSetTimeView extends StatefulWidget {
  final categoryName;
  final orderName;
  final String parentCategoryId;
  final String description;
  final String categoryId;
  const CreateOrderSetTimeView(
      {super.key,
      required this.categoryName,
      required this.orderName,
      required this.categoryId,
      required this.parentCategoryId,
      required this.description});

  @override
  State<CreateOrderSetTimeView> createState() => _CreateOrderSetTimeViewState();
}

class _CreateOrderSetTimeViewState extends State<CreateOrderSetTimeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    initialDateTime:
                        DateTime.now().add(const Duration(days: 1)),
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
                      //    deliveryDate = dateTime;
                      //    date =
                      //     '${dateTime.year}-${add0(dateTime.month)}-${add0(dateTime.day)} ${add0(dateTime.hour)}:${add0(dateTime.minute)}:${add0(dateTime.second)}';
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
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.7,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 45.0, right: 10, left: 10),
        child: GestureDetector(
          onTap: () {
            orderTimeController.text.isEmpty
                ? null
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateOrderSetAdressView(
                              categoryName: widget.categoryName,
                              dateAndTime: orderTimeController.text,
                              orderName: widget.orderName,
                              categoryId: widget.categoryId,
                              parentCategoryId: widget.parentCategoryId,
                              description: widget.description,
                            )));
          },
          child: Container(
            height: 52,
            width: MediaQuery.of(context).size.width - 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: orderTimeController.text.isEmpty
                  ? const Color(0xffEBEBEB)
                  : const Color(0xffF14F44),
            ),
            child: Center(
              child: Text('Продолжить',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: orderTimeController.text.isEmpty
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
