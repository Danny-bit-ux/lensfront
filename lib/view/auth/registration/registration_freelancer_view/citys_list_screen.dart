import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../controller/services_controller.dart';
import '../../../../domain/get_citys_list.dart';
import '../../../../main.dart';

class CitysListView extends StatefulWidget {
  final bool profile;
  final bool service;
  CitysListView({super.key,required this.profile,required this.service});

  @override
  State<CitysListView> createState() => _CitysListViewState();
}

class _CitysListViewState extends State<CitysListView> {
  @override
  Widget build(BuildContext context) {
    final watchModel = context.watch<GetCitysList>();
    watchModel.getAllCitys();
    final serviceController = Get.put(ServicesController());
    watchModel.getPopularCitys();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset('assets/design/images/arrowleft.png')),
                     Text(
                       translateController.City_search,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Image.asset('assets/design/images/cross.png'),
                  ],
                ),
                const SizedBox(height: 16,),
                Container(
                  height: 41,
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xffEBEBEB),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 3.0, top: 10),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Image.asset('assets/design/images/search.png'),
                        ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        hintText: translateController.City,
                        hintStyle:  GoogleFonts.inter(
                          fontSize: 14,
                          color: const Color(0xff808080),
                        )
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12,),
                 Text(translateController.Popular_cities, style:
                GoogleFonts.inter(
                    color: const Color(0xff808080),
                    fontWeight: FontWeight.w500,
                  ),),
                const SizedBox(height: 12,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(watchModel.popularCityList.length, (index) => GestureDetector(
                    onTap: () {
                     watchModel.selectCity(watchModel.popularCityList[index]['cityname']);
                     widget.service == false ? null : serviceController.changeCity(watchModel.popularCityList[index]['cityname']);
                     widget.profile == false ? null :watchModel.updateCity(watchModel.popularCityList[index]['cityname']);
                      Navigator.pop(context);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(watchModel.popularCityList[index]['cityname'], style:  GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),),
                        const SizedBox(height: 12,),
                        Container(
                          color: const Color(0xffEBEBEB),
                          height: 1,
                          width: MediaQuery.of(context).size.width - 40,
                        ),
                        const SizedBox(height: 12,),
                      ],
                    ),
                  )),
                ),
                 Text(translateController.List_of_cities, style:
                GoogleFonts.inter(
                  color: const Color(0xff808080),
                  fontWeight: FontWeight.w500,
                ),),
                const SizedBox(height: 12,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(watchModel.allCityList.length, (index) => GestureDetector(
                    onTap: () {
                      watchModel.selectCity(watchModel.allCityList[index]['cityname']);
                      widget.service == false ? null : serviceController.changeCity(watchModel.popularCityList[index]['cityname']);
                      widget.profile == false ? null :watchModel.updateCity(watchModel.popularCityList[index]['cityname']);
                      Navigator.pop(context);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(watchModel.allCityList[index]['cityname'], style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),),
                        const SizedBox(height: 12,),
                        Container(
                          color: const Color(0xffEBEBEB),
                          height: 1,
                          width: MediaQuery.of(context).size.width - 40,
                        ),
                        const SizedBox(height: 12,),
                      ],
                    ),
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}
