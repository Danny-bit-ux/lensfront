// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../ServerRoutes.dart';
import '../../../domain/ads/get_ads_list.dart';
import 'adverb_view.dart';
import 'create_adverb/create_adverb_select_category_view.dart';

TextEditingController _minPriceController = TextEditingController();
TextEditingController _maxPriceController = TextEditingController();
bool _loaded = false;
int currentPageIndex = 0;
PageController pageController = PageController(initialPage: 0);

class AvitoListView extends StatefulWidget {
  final bool auth;
  const AvitoListView({super.key, required this.auth});

  @override
  State<AvitoListView> createState() => _AvitoListViewState();
}

class _AvitoListViewState extends State<AvitoListView> {
  @override
  Widget build(BuildContext context) {
    final getAdverbsModel = Provider.of<GetAdsList>(context);

    _loaded == false ? {getAdverbsModel.getAdsList(), _loaded = true} : null;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Объявления'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const CreateAdverbSelectCategoryView(
                              create: true,
                            )));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.red,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Создать',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          )
          // IconButton(
          //     // onPressed: () {

          //     // },
          //     icon: const Icon(Icons.add)),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.bottomSheet(const AvitoFiltersMenu());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Фильтры',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 213,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.count(
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 20,
                    crossAxisCount: 2,
                    childAspectRatio: (100 / 153),
                    children:
                        List.generate(getAdverbsModel.adverbs.length, (index) {
                      var item = getAdverbsModel.adverbs[index];
                      return GestureDetector(
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdverbView(
                                        auth: widget.auth,
                                        adverbModel:
                                            getAdverbsModel.adverbs[index],
                                      )));
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 120,
                              child: PageView(
                                controller: pageController,
                                onPageChanged: (index) {
                                  setState(() {
                                    currentPageIndex = index;
                                  });
                                },
                                children:
                                    List.generate(item.images ?? 0, (index) {
                                  return Container(
                                    height: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(16),
                                        topLeft: Radius.circular(16),
                                      ),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            '${ServerRoutes.host}/get_photo?path=${item.ccid}&ind=${index + 1}',
                                          ),
                                          fit: BoxFit.fitWidth),
                                    ),
                                  );
                                }),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                                  List.generate(item.images ?? 0, (index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 1.5),
                                  child: CircleAvatar(
                                    radius: 3,
                                    backgroundColor: index == currentPageIndex
                                        ? Colors.red
                                        : Colors
                                            .grey, // Изменение цвета в зависимости от текущего индекса
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.age.toString(),
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    item.price.toString(),
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        item.userName,
                                        style: GoogleFonts.inter(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xff808080),
                                        ),
                                      ),
                                      Image.asset(
                                          'assets/design/images/fi_star.png'),
                                      Text(
                                        item.userRating.toString(),
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
                                          color: const Color(0xffF9CF3A),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        item.userReviews.toString(),
                                        style: GoogleFonts.inter(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xff808080),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    item.address.toString(),
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 8,
                                        color: const Color(0xff808080)),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChangeRatingBottomSheetAvito extends StatelessWidget {
  const ChangeRatingBottomSheetAvito({super.key});

  @override
  Widget build(BuildContext context) {
    final getAdverbsModel = Provider.of<GetAdsList>(context);
    return Obx(
      () => Container(
        height: 390,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 30.0),
                      child: GestureDetector(
                          child: Image.asset(
                            'assets/design/images/arrowleft.png',
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          }),
                    ),
                    Text(
                      'Рейтинг',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          getAdverbsModel.ratingMin = '0';
                        },
                        child: const Text('Сбросить'))
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      getAdverbsModel.ratingMin = '3.9';
                    },
                    child: Container(
                      height: 22,
                      width: 22,
                      decoration: getAdverbsModel.ratingMin != '3.9'
                          ? BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              border:
                                  Border.all(color: const Color(0xff3333333)))
                          : BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(100),
                            ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Исполнители от 4',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: const Color(0xff808080),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  SvgPicture.asset(
                    'assets/design/images/mini_star.svg',
                    color: const Color(0xffF9CF3A),
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              const Divider(),
              const SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      getAdverbsModel.ratingMin = '4.4';
                    },
                    child: Container(
                      height: 22,
                      width: 22,
                      decoration: getAdverbsModel.ratingMin != '4.4'
                          ? BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              border:
                                  Border.all(color: const Color(0xff3333333)))
                          : BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(100),
                            ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Исполнители от 4.5',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: const Color(0xff808080),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  SvgPicture.asset(
                    'assets/design/images/mini_star.svg',
                    color: const Color(0xffF9CF3A),
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              const Divider(),
              const SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      getAdverbsModel.ratingMin = '4.9';
                    },
                    child: Container(
                      height: 22,
                      width: 22,
                      decoration: getAdverbsModel.ratingMin != '4.9'
                          ? BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              border:
                                  Border.all(color: const Color(0xff3333333)))
                          : BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(100),
                            ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Исполнители 5',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: const Color(0xff808080),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  SvgPicture.asset(
                    'assets/design/images/mini_star.svg',
                    color: const Color(0xffF9CF3A),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              GestureDetector(
                onTap: () {
                  getAdverbsModel.getSortOrders();
                  Navigator.pop(context);
                },
                child: Container(
                  height: 52,
                  width: MediaQuery.of(context).size.width - 32,
                  decoration: BoxDecoration(
                    color: const Color(0xffF14F44),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'Применить',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChangePriceBottomSheet extends StatelessWidget {
  const ChangePriceBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final getAdverbsModel = Provider.of<GetAdsList>(context);
    return Container(
      height: 300,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: GestureDetector(
                      child: Image.asset(
                        'assets/design/images/arrowleft.png',
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      }),
                ),
                Text(
                  'Цена',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      _maxPriceController.clear();
                      _minPriceController.clear();
                      getAdverbsModel.priceMin = '0';
                      getAdverbsModel.priceMax = '9999999';
                    },
                    child: const Text('Сбросить'))
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2 - 26,
                  child: TextField(
                    controller: _minPriceController,
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(
                        color: Color(
                          0xFFCBCBCB,
                        ),
                      ),
                      hintText: 'От €',
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
                  width: MediaQuery.of(context).size.width / 2 - 26,
                  child: TextField(
                    onChanged: (_) {},
                    controller: _maxPriceController,
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(
                        color: Color(
                          0xFFCBCBCB,
                        ),
                      ),
                      hintText: 'До €',
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
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          GestureDetector(
            onTap: () {
              if (_minPriceController.text.isNotEmpty) {
                getAdverbsModel.priceMin = _minPriceController.text;
              }
              if (_maxPriceController.text.isNotEmpty) {
                getAdverbsModel.priceMax = _maxPriceController.text;
              }
              ;
              getAdverbsModel.getSortOrders();
              Navigator.pop(context);
            },
            child: Container(
              height: 52,
              width: MediaQuery.of(context).size.width - 32,
              decoration: BoxDecoration(
                color: const Color(0xffF14F44),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  'Применить',
                  style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AvitoFiltersMenu extends StatefulWidget {
  const AvitoFiltersMenu({super.key});

  @override
  State<AvitoFiltersMenu> createState() => _AvitoFiltersMenuState();
}

class _AvitoFiltersMenuState extends State<AvitoFiltersMenu> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GetAdsList>(context);
    return Container(
      height: 300,
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const CreateAdverbSelectCategoryView(
                                  create: false,
                                )));
                    setState(() {});
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        color: controller.category == null ||
                                controller.category == 'no'
                            ? const Color(0xff333333)
                            : const Color(0xffF14F44),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          controller.category.toString() == 'no'
                              ? 'Категория'
                              : controller.category.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ))),
              const SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () {
                  Get.bottomSheet(const ChangePriceBottomSheet());
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: controller.priceMax == '9999999' &&
                            controller.priceMin == '0'
                        ? const Color(0xff333333)
                        : const Color(0xffF14F44),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 12),
                    child: Text(
                      controller.priceMax == '9999999' &&
                              controller.priceMin == '0'
                          ? 'Цена'
                          : "От ${controller.priceMin} до ${controller.priceMax}",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () {
                  controller.changeCategory(null);
                  controller.clearFilters();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff333333),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 12),
                    child: Text(
                      'Сбросить фильтры',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
