import 'package:flutter/material.dart';

import '../main/home_view.dart';

class ServiceCard extends StatelessWidget {
  final String name;
  final String price;
  final String categoryName;
  final monday;
  final tuesday;
  final wednesday;
  final thursday;
  final friday;
  final saturday;
  final sunday;
  final String time;
  const ServiceCard(
      {super.key,
      required this.name,
      required this.price,
      required this.time,
      required this.categoryName,
      required this.sunday,
      required this.saturday,
      required this.friday,
      required this.thursday,
      required this.tuesday,
      required this.wednesday,
      required this.monday});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(upperfirst(name)),
              Text(upperfirst(categoryName),style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),),
              const SizedBox(
                height: 4,
              ),
               Text('$price€',
               style: const TextStyle(
                 fontSize: 18
               ),),
              Row(
                children: [
                  monday == '1' ?  const Text('Пн, ' ,style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff808080),
                  ),)  :const SizedBox(),
                  tuesday == '1' ?  const Text('Вт, ' ,style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff808080),
                  ),)  :const SizedBox(),
                  wednesday == '1' ?  const Text('Ср, ' ,style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff808080),
                  ),)  :const SizedBox(),
                  thursday == '1' ?  const Text('Чт, ' ,style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff808080),
                  ),)  :const SizedBox(),
                  friday == '1' ?  const Text('Пт, ' ,style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff808080),
                  ),)  :const SizedBox(),
                  saturday == '1' ?  const Text('Сб, ' ,style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff808080),
                  ),)  :const SizedBox(),
                  sunday == '1' ?  const Text('Вс, ' ,style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff808080),
                  ),)  :const SizedBox(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
