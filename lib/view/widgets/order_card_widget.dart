// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../ServerRoutes.dart';
import '../../domain/user/get_user_profile.dart';
import '../main/home_view.dart';
import '../main/profile/my_profile/edit_order_view.dart';
import '../main/profile/other_profile/other_freelancer_profile_view.dart';
import '../main/profile/other_user_profile_view.dart';

class OrderCardWidget extends StatelessWidget {
  final item;
  final profileModel;
  final bool myOrders;
  const OrderCardWidget(
      {super.key,
      required this.item,
      required this.myOrders,
      required this.profileModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 32,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  upperfirst(item.name),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
               myOrders == true?  IconButton(onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>EditOrderView(orderModel: item)));
               }, icon: const Icon(Icons.edit)) : const SizedBox(),
              ],
            ),
            Text(
              item.dateAndTime,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            item.remotely == '0' || item.remotely == 0
                ? Row(
                    children: [
                      const Icon(
                        Icons.near_me,
                        color: Colors.grey,
                        size: 12,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        item.address,
                        style: GoogleFonts.inter(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  )
                : const Text('Удалённо'),
            const SizedBox(
              height: 4,
            ),
            Text(
              item.fixPrice == '1'
                  ? "${item.priceMin}€"
                  : item.notPrice == '1'
                      ? 'Договорная'
                      : "${item.priceMin}-${item.priceMax}€",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            myOrders == true
                ? Row(
                    children: List.generate(
                        item.responses.length,
                        (index) => GestureDetector(
                              onTap: () async {
                                var user = await profileModel
                                    .getOtherUserProfile(int.parse(item.uid));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OtherUserProfileView(
                                                user: user,
                                                uid: int.parse(item
                                                    .responses[index].uid))));
                              },
                              child: Center(
                                child: GestureDetector(
                                  onTap: () async {
                                    final userModel =
                                    Provider.of<GetUserProfile>(context, listen: false);
                                    final user = await userModel.getOtherUserProfile(item.responses[index].uid);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => OtherFreelancerProfileView(
                                                thisUid: item.responses[index].uid, userModel: user)));
                                  },
                                  child: CircleAvatar(
                                      backgroundColor:
                                          Colors.white.withOpacity(0),
                                      radius: 20,
                                      backgroundImage: NetworkImage(
                                          '${ServerRoutes.host}/avatar?path=avatar_${item.responses[index].uid}') ),
                                ),
                                // AssetImage('assets/dwd_logo.jpeg'),
                              ),
                            )),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
