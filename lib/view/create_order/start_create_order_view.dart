import 'package:flutter/material.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:provider/provider.dart';

import '../../domain/get_catigories.dart';
import '../widgets/list_categories.dart';

class StartCreateOrder extends StatelessWidget {
  const StartCreateOrder({super.key});

  @override
  Widget build(BuildContext context) {
    final watchModel = context.watch<GetCatigories>();
    //watchModel.getCategories();

    watchModel.getCat();
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              16.widthBox,
              Image.asset('assets/design/images/arrowleft.png'),
              3.widthBox,
              Text('Создание заявки')
            ],
          ),
          20.heightBox,
          CatigoriesListWidget(),
        ],
      ),
    ));
  }
}
