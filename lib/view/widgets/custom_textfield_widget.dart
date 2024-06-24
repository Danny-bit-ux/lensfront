import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

bool see = true;
class CustomTextFieldWidget extends StatefulWidget {
  final controller;
  final text;
  final password;
  var onChange;
  TextInputType? textInputType;
  CustomTextFieldWidget({super.key,required this.controller, required this.text, required this.password, this.onChange,
   this.textInputType});

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return  TextField(
      keyboardType: widget.textInputType ?? TextInputType.text,
         controller: widget.controller,
      onChanged: widget.onChange,
      decoration: InputDecoration(

        hintStyle: GoogleFonts.inter(
          color: const Color(
            0xFFCBCBCB,
          ),
        ),
        hintText: widget.text,
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
        suffixIcon: widget.password == true ? IconButton(onPressed: () {
          see  = !see;
          setState(() {
          });
        }, icon: SvgPicture.asset(
          see == true
              ? 'assets/svg/eye_off.svg'
              : 'assets/svg/eye_on.svg',
          fit: BoxFit.scaleDown,
        ) ) : null,
      ),
      obscureText: widget.password == true ? true && see == true : false ,
    );
  }
}
