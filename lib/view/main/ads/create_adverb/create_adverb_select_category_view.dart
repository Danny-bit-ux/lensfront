import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../../../data/adverb_categories_data.dart';
import '../../../../domain/ads/get_ads_list.dart';
import '../../../../model/adverb_category_model.dart';
import 'create_adverb_set_name_view.dart';

class CreateAdverbSelectCategoryView extends StatelessWidget {
 final bool create;
  const CreateAdverbSelectCategoryView({super.key,required this.create});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Объявление о продаже/покупке',
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.builder(
          itemBuilder: (context, index) {
            AdverbCategoryModel item = adsCategories[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  CategoryCardWidget(empty: item.pods.isEmpty, item: item, viewModel: item.viewModel,create: create,),
                ],
              ),
            );
          },
          itemCount: adsCategories.length,
        ),
      ),
    );
  }
}

class CategoryCardWidget extends StatelessWidget {
  bool empty;
  AdverbCategoryModel item;
  final viewModel;
  final bool create;
  CategoryCardWidget({super.key, required this.empty, required this.item, required this.viewModel,required this.create});

  @override
  Widget build(BuildContext context) {
    final getAdverbsModel = Provider.of<GetAdsList>(context);
    return empty == false
        ? ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            initiallyExpanded: false,
            title: Text(
              item.name,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            children: List.generate(
                item.pods.length,
                (index) => CategoryCardWidget(
                  viewModel: viewModel,
                    empty: item.pods[index].pods.isEmpty,
                    item: item.pods[index], create: create,)))
        : GestureDetector(
      onTap: () {
    create == true?    Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAdverbSetNameView(categoryName: item.name, viewModel: item.viewModel,type: item.type,))) : {getAdverbsModel.changeCategory(item.name),
    Navigator.pop(context)};
      },
          child: ListTile(
              title: Text(
                item.name,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
        );
  }
}
