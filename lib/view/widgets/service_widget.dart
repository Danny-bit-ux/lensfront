import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ServicesWidget extends StatelessWidget {
  final String name;
  final String image;
  final Color color;
  final double width;
  final double height;
  final double sizew;
  final double sizeh;
  const ServicesWidget({
    super.key,
    required this.name,
    required this.image,
    required this.color,
    required this.width,
    required this.height,
    required this.sizew,
    required this.sizeh,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration:
      BoxDecoration(color: color, borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0, top: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
            Image.asset(
              image,
              width: sizew,
              height: sizeh,
            )
          ],
        ),
      ),
    );
  }
}
