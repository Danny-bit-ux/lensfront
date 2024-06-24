import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlensfront/view/no_login/no_login_main.dart';
import 'package:provider/provider.dart';
import 'controller/edit_profile_controller.dart';
import 'controller/fill_adverb_controller.dart';
import 'controller/send_for_user_controller.dart';
import 'controller/translate_contoller.dart';
import 'data/chat_data_repository.dart';
import 'domain/ads/create_adverb.dart';
import 'domain/ads/get_ads_list.dart';
import 'domain/get_categories_list.dart';
import 'domain/get_catigories.dart';
import 'domain/get_citys_list.dart';
import 'domain/order/get_order_from_id.dart';
import 'domain/order/get_orders_from_cat.dart';
import 'domain/order/get_orders_list.dart';
import 'domain/response_from_order.dart';
import 'domain/user/auth/create_user.dart';
import 'domain/user/get_user_profile.dart';
import 'model/translate_model.dart';

TranslateModel translateController = TranslateController().translateModel;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SendForUserController()),
        ChangeNotifierProvider(create: (context) => GetOrdersFromCategory()),
        ChangeNotifierProvider(create: (context) => GetAdsList()),
        ChangeNotifierProvider(create: (context) => GetUserProfile()),
        ChangeNotifierProvider(create: (context) => CreateUser()),
        ChangeNotifierProvider(create: (context) => GetCitysList()),
        ChangeNotifierProvider(create: (context) => TranslateController()),
        ChangeNotifierProvider(create: (context) => ResponseFromOrder()),
        ChangeNotifierProvider(create: (context) => GetOrderFromId()),
        ChangeNotifierProvider(create: (context) => GetCategoriesList()),
        ChangeNotifierProvider(create: (context) => ChatDataRepository()),
        ChangeNotifierProvider(create: (context) => GetOrdersList()),
        ChangeNotifierProvider(create: (context) => GetCatigories()),
        ChangeNotifierProvider(create: (context) => CreateAdverb()),
        ChangeNotifierProvider(create: (context) => FillAdverbModel()),
        ChangeNotifierProvider(create: (context) => EditProfileController()),
      ],
      child: const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        //home: StartCreateOrder(),
        home: NoLoginMainScreen(),
      ),
    );
  }
}
