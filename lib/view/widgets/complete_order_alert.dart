import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/order/get_orders_list.dart';
import '../../domain/user/auth/create_user.dart';
import '../main/profile/my_profile/my_order_info_view.dart';

class CompleteOrderView extends StatefulWidget {
  const CompleteOrderView({super.key});

  @override
  State<CompleteOrderView> createState() => _CompleteOrderAlertState();
}

class _CompleteOrderAlertState extends State<CompleteOrderView> {
  final star = Image.asset(
    "assets/design/images/fi_star.png",
    scale: 0.3,
  );

  @override
  Widget build(BuildContext context) {
    final orderModel = context.read<GetOrdersList>();
    final userModel = context.watch<CreateUser>();
    orderModel.getMyOrders(int.parse(uid));
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(child: Image.asset('assets/design/images/arrowleft.png'),onTap: () {
                Navigator.pop(context);
              },),
              const Text(
                'Мои заявки',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 13,),
            ],
          ),
          const SizedBox(height: 25,),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(child: Image.asset('assets/design/images/arrowleft.png'),onTap: () {
                    Navigator.pop(context);
                  },),
                  const Text(
                    'Мои заявки',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 13,),
                ],
              ),
                const SizedBox(height: 25,),
                Container(
                    width: MediaQuery.of(context).size.width * 0.89,
                    height: 41,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12)),
                    child: MaterialButton(
                      onPressed: () {
                      },
                      child: const TextField(
                        // controller: controller,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Поиск",
                            prefixIcon: Icon(Icons.search),
                            prefixStyle: TextStyle(color: Colors.grey)),
                      ),
                    )),
                const SizedBox(height: 16,),
                const Text('Мои заявки',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff333333),
                  ),),
                const SizedBox(height: 12,),
                Column(
                  children: List.generate(orderModel.myOrders.length, (index) {
                    var item = orderModel.myOrders[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: InkWell(
                        onTap: () {
                       //   Navigator.push(context, MaterialPageRoute(builder: (context) =>  MyOrderInfoView(item: item,)));
                        },
                        child: Container(
                          //height: 106,
                          width: MediaQuery.of(context).size.width - 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: const Color(0xffFFFFFF)
                          ),
                          child:  Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.name, style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),),
                                const SizedBox(height: 8,),
                                Text(item.name, style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffCBCBCB),
                                ),),
                                const SizedBox(height: 4,),
                                Text(item.city, style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffCBCBCB),
                                ),),
                                const SizedBox(height: 8,),
                                Row(
                                  children: [
                                    Text('${item.priceMin}-${item.priceMax}\$',style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
                                    const SizedBox(width: 12,),
                                    Image.asset('assets/design/images/card.png'),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );}),
                ),
                  ]),
            ),
          ),
        ],
      ));
  }

  AlertDialog CompleteTheOrder(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(35)),
          side: BorderSide(color: Color(0xffF14F44), width: 2)),
      actions: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 28),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "Завершить заказ?",
              style: TextStyle(fontSize: 22),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: SizedBox(
                      height: 42,
                      child: ElevatedButton(
                          onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) =>
                                  Review(context)),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xffF14F44)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12)))),
                          child: const Text("Да"))),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: SizedBox(
                      height: 42,
                      child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xff333333)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12)))),
                          child: const Text("Нет"))),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  AlertDialog Review(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(35)),
          side: BorderSide(color: Color(0xffF14F44), width: 2)),
      actions: <Widget>[
         Padding(
          padding: const EdgeInsets.only(left: 64),
          child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(
                  Icons.close_rounded,
                  weight: 24,
                ), onPressed: () => Navigator.pop(context),
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 28, right: 28, bottom: 28),
          child: Column(
            children: [
              const Text(
                "Спасибо за выолнение заказа!",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const Text(
                      "Вы можете оставить отзыв об заказчике.",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [star, star, star, star, star],
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                child: Expanded(
                  child: SizedBox(
                    height: 140,
                    child: TextField(
                      maxLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                          hintText:
                              "Напишите, что понравилось в работе с заказчиком",
                          hintStyle: TextStyle(
                            color: Color(0xffCBCBCB),
                            fontSize: 14,
                            overflow: TextOverflow.visible,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black54),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black54),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)))),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: SizedBox(
                          height: 42,
                          child: ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xffF14F44)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)))),
                              child: const Text("Оставить отзыв"))),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
