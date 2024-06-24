import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/order_controller.dart';
import '../../../../model/order_model.dart';
import '../../../widgets/custom_textfield_widget.dart';

FocusNode _focusNode = FocusNode();
TextEditingController _orderNameController = TextEditingController();
TextEditingController _minPriceController = TextEditingController();
TextEditingController _maxPriceController = TextEditingController();
TextEditingController _descriptionController = TextEditingController();
TextEditingController _locationController = TextEditingController();

class EditOrderView extends GetView<OrderController> {
  final OrderModel orderModel;
  const EditOrderView({super.key, required this.orderModel});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderController());
    _locationController.text = orderModel.address.toString();
    _orderNameController.text = orderModel.name.toString();
    _maxPriceController.text = orderModel.priceMax.toString();
    _minPriceController.text = orderModel.priceMin.toString();
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Редактировать заявку'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Название заказа'),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFieldWidget(
                    controller: _orderNameController,
                    text: 'Название заказа',
                    password: false),
                const SizedBox(
                  height: 12,
                ),
                const Text('Минимальная цена'),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFieldWidget(
                    controller: _minPriceController,
                    text: 'Минимальная цена',
                    password: false),
                const SizedBox(
                  height: 12,
                ),
                const Text('Максимальная цена'),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFieldWidget(
                    controller: _maxPriceController,
                    text: 'Максимальная цена',
                    password: false),
                const SizedBox(
                  height: 12,
                ),
                const Text('Адрес'),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFieldWidget(
                    controller: _locationController,
                    text: 'Адрес',
                    password: false),
                const SizedBox(
                  height: 12,
                ),
                const Text('Адрес'),
                const SizedBox(
                  height: 4,
                ),
                TextField(
                  onChanged: (_) {},
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
                GestureDetector(
                  onTap: () {
                    controller.updateOrder(
                        orderModel.id,
                        _minPriceController.text,
                        _maxPriceController.text,
                        _orderNameController.text,
                        _locationController.text,
                        _descriptionController.text);
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 52,
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xffF14F44),
                    ),
                    child: const Center(
                      child: Text(
                        'Изменить',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
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
