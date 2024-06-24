import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newlensfront/view/auth/registration/registration_freelancer_view/registration_freelancer_first_view.dart';

import '../../../main.dart';
import 'registration_ customer_view/registration_customer_first_view.dart';

class SelectRegTypeView extends StatelessWidget {
  const SelectRegTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 30,),
                  SvgPicture.asset('assets/svg/profilogo.svg',height: MediaQuery.of(context).size.width /2,width:  MediaQuery.of(context).size.width /2,),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 23,),
               Text(translateController.How_do_you_want_to_register_q, style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                fontSize: 26,
              ),
              textAlign: TextAlign.center,),
              SizedBox(height: MediaQuery.of(context).size.height / 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationFreelancerFirstView()));
                  },
                  child: Container(
                    height: 52,
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xffD0D4B1),
                    ),
                    child:  Center(
                      child: Text(translateController.As_a_contractor, style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white,
                      ),),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 79,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationCustomerFirstView()));
                  },
                  child: Container(
                    height: 52,
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xffACC1B4),
                    ),
                    child:  Center(
                      child: Text(translateController.As_a_customer, style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white,
                      )),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12,),
              Center(
                child: TextButton(onPressed: () {
                  Navigator.pop(context);
                }, child: const Text('Назад')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
