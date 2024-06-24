// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:untitled1/view/auth/registration/registration_freelancer_view/setFreelancer_1_view.dart';
//
// import '../../../../main.dart';
//
// class RegistrationFreelancerSecondScreen extends StatefulWidget {
//   String email;
//   String password;
//   RegistrationFreelancerSecondScreen({super.key, required this.email, required this.password});
//
//   @override
//   State<RegistrationFreelancerSecondScreen> createState() => _RegistrationCustomerSecondScreenState();
// }
//
// class _RegistrationCustomerSecondScreenState extends State<RegistrationFreelancerSecondScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     GestureDetector(child: Image.asset('assets/design/images/cross.png',),
//                     onTap: (){
//                       Navigator.pop(context);
//                     },),
//                      Text(
//                        translateController.Register,
//                       style: GoogleFonts.inter(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 15,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 24,),
//                  Text(translateController.Confirm_your_email, style: GoogleFonts.inter(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 22,
//                 ),),
//                 const SizedBox(height: 12,),
//                 Center(
//                   child: Form(
//                     child: PinCodeTextField(
//                       appContext: context,
//                       length: 6,
//                       animationType: AnimationType.fade,
//                       validator: (v) {
//                         if (v!.length < 6) {
//                           return null;
//                           // return 'Введите код из смс-сообщения';
//                         } else {
//                           return null;
//                         }
//                       },
//                       pinTheme: PinTheme(
//                         activeColor: Colors.black,
//                         shape: PinCodeFieldShape.box,
//                         borderRadius: BorderRadius.circular(12),
//                         activeFillColor: const Color(0xFFFAFAFA),
//                         inactiveBorderWidth: 0.5,
//                         activeBorderWidth: 0.5,
//                         selectedBorderWidth: 0.5,
//                         selectedColor: Colors.black,
//                         selectedFillColor: Colors.white,
//                         inactiveColor: Colors.black,
//                         inactiveFillColor: Colors.white,
//
//                       ),
//                       cursorColor: Colors.black,
//                       animationDuration: const Duration(milliseconds: 150),
//                       keyboardType: TextInputType.number,
//                       onCompleted: (v) {
//                       },
//                     ),
//                   ),
//                 ),
//                  Center(
//                   child:
//                   Text(translateController.Send_a_new_code, style: GoogleFonts.inter(
//                     color: const Color(0xffF14F44),
//                     decoration: TextDecoration.underline,
//                   ),),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height / 3.9,),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => SetFreelancer1view(email: widget.email, password: widget.password,)));
//                   },
//                   child: Container(
//                     height: 52,
//                     width: MediaQuery.of(context).size.width - 10,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       color: const Color(0xffF14F44),
//                     ),
//                     child:  Center(
//                       child: Text(translateController.Register, style: GoogleFonts.inter(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 16,
//                         color: Colors.white,
//                       )),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
// }
