import 'package:flutter/material.dart';
import '../main/ads/avito_list_view.dart';

class ArendaProdajaCardWidget extends StatelessWidget {
  const ArendaProdajaCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width * 0.89,
      height: 72,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(221, 230, 251, 1),
          borderRadius: BorderRadius.circular(14)),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                  const AvitoListView(auth: true,)));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Аренда или продажа",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  Text(
                    "Недвижимости, автомобиля, вещей",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  )
                ],
              ),
            ),
            Image.asset("image/House.png")
          ],
        ),
      ),
    );
  }
}
