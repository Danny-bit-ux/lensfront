// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../ServerRoutes.dart';
import '../../controller/chat_controller.dart';
import '../../domain/response_from_order.dart';
import '../../domain/user/auth/create_user.dart';
import '../../domain/user/get_user_profile.dart';
import '../../model/order_model.dart';
import '../main_view.dart';
import '../no_login/no_login_home.dart';
import '../widgets/custom_textfield_widget.dart';
import 'profile/other_profile/other_freelancer_profile_view.dart';

FocusNode _focusNode = FocusNode();
TextEditingController priceCo = TextEditingController();
TextEditingController dateCO = TextEditingController();
TextEditingController kom = TextEditingController();
MapController mapController = MapController();
class ResponseOrderView extends StatefulWidget {
  final dynamic id;
  final OrderModel item;
  final dynamic uid;
  final dynamic description;
  final  dynamic orderStatus;
  final dynamic city;
  final dynamic address;
  final dynamic wishes;
  final dynamic sees;
  final dynamic name;
  final dynamic dateStart;
  final dynamic category;
  final dynamic freelancer;
  final dynamic ccid;
  final dynamic images;
  final dynamic lat;
  final dynamic long;
  const ResponseOrderView(
      {super.key,
      required this.item,
      required this.id,
      required this.freelancer,
      required this.uid,
      required this.name,
      required this.city,
      required this.sees,
      required this.ccid,
      required this.orderStatus,
      required this.category,
      required this.wishes,
      required this.address,
      required this.description,
      required this.dateStart,
      required this.images,
        required this.long,
        required this.lat,
      });

  @override
  State<ResponseOrderView> createState() => _ResponseOrderViewState();
}

class _ResponseOrderViewState extends State<ResponseOrderView> {
  @override
  Widget build(BuildContext context) {
  final image = NetworkImage('${ServerRoutes.host}/avatar?path=avatar_${widget.uid}');
    return Scaffold(
      // appBar: AppBar(
      //   title:  Text(
      //    upperfirst(widget.name),
      //     style: const TextStyle(
      //       fontWeight: FontWeight.w500,
      //       fontSize: 16,
      //     ),
      //   ),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child:
                        Image.asset('assets/design/images/arrowleft.png')),
                    Text(
                      '${widget.name}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.item.fixPrice == '1'
                                ? "${widget.item.priceMin}€"
                                : widget.item.notPrice == '1'
                                ? 'Договорная'
                                : "${widget.item.priceMin}-${widget.item.priceMax}€",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                widget.sees.toString(),
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Image.asset('assets/design/images/eye.png')
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        upperfirst(widget.address.toString()),
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff333333)),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                        color: const Color(0xffEBEBEB),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      const Text(
                        'Описание',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color(0xff808080),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        upperfirst(widget.description.toString()),
                        style: const TextStyle(
                          color: Color(0xff333333),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'Пожелания',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color(0xff808080),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        upperfirst(widget.wishes.toString()),
                        style: const TextStyle(
                          color: Color(0xff333333),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'Начать',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color(0xff808080),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        widget.dateStart.toString(),
                        style: const TextStyle(
                          color: Color(0xff333333),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      widget.images != 0
                          ? const Text(
                              'Фото',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Color(0xff808080),
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: widget.images == 0
                            ? 0
                            : widget.images % 3 == 0
                            ? (widget.images ~/ 3) * 110.0
                            : (widget.images ~/ 3) * 110.0 + 110.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: widget.images,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 1, // Set the aspect ratio as needed
                                  ),
                                  itemBuilder: (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                contentPadding: EdgeInsets.zero,
                                                content: Image.network(
                                                    '${ServerRoutes.host}/get_photo?path=${widget.ccid}&ind=${index + 1}'
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          height: 108,
                                          width: 108,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  '${ServerRoutes.host}/get_photo?path=${widget.ccid}&ind=${index + 1}'
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24,),
                      const Text(
                        'Заказчик',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff333333),
                        ),
                      ),
                      const SizedBox(height: 24,),
                      GestureDetector(
                        onTap: () async {
                          final userModel =
                          Provider.of<GetUserProfile>(context, listen: false);
                          final user = await userModel.getOtherUserProfile(widget.item.uid);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> OtherFreelancerProfileView(thisUid: widget.item.uid, userModel: user)));
                        },
                        child: Container(
                          height: 88,
                          width: MediaQuery.of(context).size.width-32,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CircleAvatar(radius: 32,
                                backgroundImage: image,),
                                const SizedBox(width: 8,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(widget.item.username.toString(), style: const TextStyle(
                                      fontSize: 18,fontWeight: FontWeight.bold,
                                    ),),
                                    Row(
                                      children: [
                                        Text(
                                          '5.0',
                                          style: GoogleFonts.inter(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xffF9CF3A)),
                                        ),
                                        SvgPicture.asset(
                                          'assets/design/images/mini_star.svg',
                                          color: const Color(0xffF9CF3A),
                                          height: 24,
                                          width: 24,
                                        ),
                                        const SizedBox(width: 4,),
                                        Text(
                                          '5 отзывов',
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: const Color(0xff808080),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                widget.freelancer == '1'
                    ? BottonSh(
                  responses: widget.item.responsesUids,
                        uid2: widget.uid,
                        id: widget.id,
                        uid: uid,
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottonSh extends StatefulWidget {
  final dynamic id;
  final dynamic uid;
  final dynamic uid2;
  final List responses;
  const BottonSh(
      {super.key, required this.id, required this.uid, required this.uid2,required this.responses});

  @override
  State<BottonSh> createState() => _BottonShState();
}

class _BottonShState extends State<BottonSh> {
  @override
  Widget build(BuildContext context) {
    final createModel = context.read<ResponseFromOrder>();
    final chatModel = Get.put(ChatController());
    return GestureDetector(
      onTap: () {
            Scaffold.of(context).showBottomSheet((BuildContext context) {
              return GestureDetector(
                onTap: () {
                  _focusNode.unfocus();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height - 100,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Image.asset(
                                      'assets/design/images/arrowleft.png')),
                              const Text(
                                'Откикнуться',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 26),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            'Стоимость работ',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                          CustomTextFieldWidget(
                              controller: priceCo,
                              text: '10 \$',
                              password: false),
                          const SizedBox(
                            height: 12,
                          ),
                          const Text(
                            'Дата выполнения',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              DatePicker.showDatePicker(
                                context,
                                pickerMode: DateTimePickerMode.datetime,
                                initialDateTime:
                                DateTime.now().add(const Duration(days: 1)),
                                minDateTime: DateTime.now(),
                                maxDateTime:
                                DateTime.now().add(const Duration(days: 365)),
                                locale: DateTimePickerLocale.en_us,
                                dateFormat: "dd MMMM yyyy",
                                onChange: (dateTime, selectedIndex) {
                                  dateCO.text =
                                      dateTime.toString().substring(0, 10);
                                  setState(() {});
                                },
                                onConfirm: (dateTime, selectedIndex) {
                                  dateCO.text =
                                      dateTime.toString().substring(0, 10);
                                },
                              );
                            },
                            child: TextField(
                              controller: dateCO,
                              decoration: InputDecoration(
                                enabled: false,
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
                            'Комментарий к отклику',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                          TextField(
                            focusNode: _focusNode,
                            maxLines: 10,
                            minLines: 5,
                            maxLength: 1000,
                            controller: kom,
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
                          SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height / 13,
                          ),
                          GestureDetector(
                            onTap: () {
                              kom.clear();
                              chatModel.createChat(
                                  type: '0',
                                  uid1: widget.uid,
                                  uid2: widget.uid2,
                                  pid: widget.id);
                              createModel.responseFromOrder(
                                  uid: int.parse(widget.uid),
                                  pid: widget.id,
                                  date_and_time: dateCO.text,
                                  timestamp: DateTime.now().toString(),
                                  price: int.parse(priceCo.text),
                                  comment: kom.text);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MainView()));
                            },
                            child: Container(
                              height: 52,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width - 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color(0xffF14F44),
                              ),
                              child: const Center(
                                child: Text(
                                  'Подтвердить',
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
            }, backgroundColor: Colors.black.withOpacity(0.5));
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
            'Откликнуться',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
