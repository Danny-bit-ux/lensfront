import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main_view.dart';


class TopRowWidget extends StatelessWidget {
  final String text;
  const TopRowWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(child: Image.asset('assets/design/images/arrowleft.png'),onTap: () {
          Navigator.pop(context);
        },),
         Text(
          text,
          style:  GoogleFonts.abel(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const MainView()), (route) => false);
          },
            child: Image.asset('assets/design/images/cross.png')),
      ],
    );
  }
}
