import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:newlensfront/view/main/profile/my_profile/service/create_services_view.dart';
import 'package:provider/provider.dart';

import '../../domain/user/get_user_profile.dart';
import 'create_order/create_order_select_category.dart';
class SelectPostType extends StatelessWidget {
  const SelectPostType({super.key});

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<GetUserProfile>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    SvgPicture.asset('assets/svg/profilogo.svg',height: MediaQuery.of(context).size.width /2,width:  MediaQuery.of(context).size.width /2,),

                  ],
                ),

                const SizedBox(
                  height: 32,
                ),
                const Text(
                  'Создавайте заказы и находите лучших фотографов',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const CreateOrderSelectCategory()));
                  },
                  child: Container(
                    height: 57,
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.red,
                    ),
                    child: const Center(
                      child: Text(
                        'Создать заявку',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                GestureDetector(
                  onTap: () {
                  if(userModel.userModel?.freelancer == '1') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const CreateServicesView()));
                  }else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Необходимо быть исполнителем')));
                  }
                  },
                  child: Container(
                    height: 57,
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xff333333),
                    ),
                    child: const Center(
                      child: Text(
                        'Создать услугу',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
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
