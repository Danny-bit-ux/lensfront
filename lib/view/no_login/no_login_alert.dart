
import 'package:flutter/material.dart';

import '../auth/start_screen.dart';


class NoLoginAlert extends StatelessWidget {
  const NoLoginAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: MediaQuery.of(context).size.width-48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Чтобы перейти в данный раздел необходимо авторизоваться',textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),),
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>StartView()), (route) => false);
              },
              child: Container(height: 52,
              width: MediaQuery.of(context).size.width  -54,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
                child: const Center(
                  child: Text('Войти',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
