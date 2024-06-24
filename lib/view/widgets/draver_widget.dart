import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';


import '../../ServerRoutes.dart';
import '../../controller/order_controller.dart';
import '../../controller/user_controller.dart';
import '../../domain/user/auth/create_user.dart';
import '../../domain/user/get_user_profile.dart';
import '../auth/registration/registration_freelancer_view/set_freelancer_success.dart';
import '../main/profile/customer_profile.dart';
import '../main/profile/my_profile/change_password_view.dart';
import '../main/profile/my_profile/my_adverbs_view.dart';
import '../main/profile/my_profile/my_orders_view.dart';
import '../main/profile/my_profile/profile_view.dart';
import '../main/services/freelancer_requests_view.dart';
import '../order/complete_orders_view.dart';
import '../order/my_responses_view.dart';
import '../order/work_orders_list_view.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final userModel = context.watch<GetUserProfile>();
    final responseController = Get.put(OrderController());
    responseController.getMyResponses(uid);
    userModel.getUserProfile(int.parse(uid));
    return Drawer(
      width: 350,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 21, right: 20),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.clear)),
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              userModel.userModel!.freelancer == '1'
                                  ? const ProfileView()
                                  : const CustomerProfileView()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            const Center(
                              child: CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    AssetImage('assets/dwd_logo.jpeg'),
                                // AssetImage('assets/dwd_logo.jpeg'),
                              ),
                            ),
                            Center(
                              child: CircleAvatar(
                                backgroundColor: Colors.white.withOpacity(0),
                                radius: 25,
                                backgroundImage: NetworkImage(
                                    '${ServerRoutes.host}/avatar?path=avatar_$uid'),
                                // AssetImage('assets/dwd_logo.jpeg'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userModel.userModel!.name,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              userModel.userModel!.email,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                     Row(
                      children: [
                        Text(
                          userModel.userModel!.rating.toString(),
                          style: const TextStyle(color: Colors.amber),
                          textAlign: TextAlign.center,
                        ),
                        const Icon(
                          Icons.star_rate_rounded,
                          color: Colors.amber,
                          size: 24,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyOrdersView()));
                },
                child: const Text(
                  "Мои заявки",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FreelancerRequestView()));
                },
                child: const Text(
                  "Записи ко мне",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyAdverbsView()));
                },
                child: const Text(
                  "Мои объявления",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
              userModel.userModel!.freelancer == '1'
                  ? const SizedBox(
                      height: 16,
                    )
                  : const SizedBox(),
              userModel.userModel!.freelancer == '1'
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CompleteOrdersView()));
                      },
                      child: const Text(
                        "Завершённые заказы",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    )
                  : const SizedBox(),
              userModel.userModel!.freelancer == '1'
                  ? const SizedBox(
                      height: 16,
                    )
                  : const SizedBox(),
              userModel.userModel!.freelancer == '1'
                  ? InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyResponsesView()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Мои отклики на заказы",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          responseController.myResponses.isNotEmpty
                              ? Container(
                                  height: 24,
                                  width: 24,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Center(
                                    child: Text(
                                      responseController.myResponses.length
                                          .toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    )
                  : const SizedBox(),
              userModel.userModel!.freelancer == '1'
                  ? const SizedBox(
                      height: 16,
                    )
                  : const SizedBox(),
              userModel.userModel!.freelancer == '1'
                  ? InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const WorkOrdersListView()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Заказы в работе",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          responseController.workOrders.isNotEmpty
                              ? Container(
                                  height: 24,
                                  width: 24,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Center(
                                    child: Text(
                                      responseController.workOrders.length
                                          .toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 16,
              ),
              const InkWell(
                  child: Text(
                "Поддержка",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              )),
              const SizedBox(
                height: 16,
              ),
              const InkWell(
                  child: Text(
                "О приложении",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              )),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChangePasswordView()));
                  },
                  child: const Text(
                    "Смена пароля",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  )),
              const SizedBox(
                height: 16,
              ),
              Text(
                userModel.userModel!.city ?? '',
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 32,
              ),
              userModel.userModel!.freelancer == '0'
                  ? GestureDetector(
                      onTap: () {
                        UserController().setFreelancer();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SetFreelancerSuccess()));
                      },
                      child: Container(
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.red)),
                        child: const Center(
                          child: Text(
                            "Стать специалистом",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 28,
              )
            ],
          ),
        ),
      ),
    );
  }
}
