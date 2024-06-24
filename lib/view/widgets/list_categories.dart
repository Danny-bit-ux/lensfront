import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:awesome_extensions/awesome_extensions.dart';

import '../../domain/get_catigories.dart';
import '../../models/category_model.dart';

class CatigoriesListWidget extends StatelessWidget {
  const CatigoriesListWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final watchModel = context.watch<GetCatigories>();

    watchModel.getCat();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      //16.0.heightBox,

      2.heightBox,
      SizedBox(
          height: context.height - 183,
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    watchModel.categoryList.length,
                    //print( watchModel.categoryList.length);
                    //print(watchModel.categoryList.length),
                    (index) => _subcategoryBuild(
                        watchModel.categoryList[index], context, 0),
                  ))))
    ]);
  }

  Widget _subcategoryBuild(
      Category_model list, BuildContext context, int ischild) {
    if (list.subcategories!.isEmpty) {
      return ListTile(
          // onTap: () => Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => CreateOrderSetName(
          //               name: list.name,
          //             ))),
          //-*leading: SizedBox(),
          title: Text(
            list.name,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ));
    }
    return ExpansionTile(
      //leading: Icon(list.icon),
      initiallyExpanded: false,
      title: Text(
        list.name,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      children: list.subcategories!
          .map((subcat) => _subcategoryBuild(subcat, context, 1))
          .toList(),
    );
  }
}
