import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../auth/start_screen.dart';

class NoLoginChat extends StatelessWidget {
  const NoLoginChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Чтобы перейти в данный раздел необходимо авторизоваться',textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),),
              const SizedBox(height: 48,),
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
                    child: Text('Зарегистрироваться',
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
      ),
    );
  }
}
