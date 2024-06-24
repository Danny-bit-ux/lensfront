 import 'package:flutter/material.dart';

import '../widgets/custom_textfield_widget.dart';

 TextEditingController _flourEditingController = TextEditingController();
 TextEditingController _squareEditingController = TextEditingController();
 String _repair = 'Ремонт';
 String _rules = 'Право собственности';

class CreateAvdHomeViewModel extends StatefulWidget {
  const CreateAvdHomeViewModel({super.key});

  @override
  State<CreateAvdHomeViewModel> createState() => _CreateAvdHomeViewModelState();
}

class _CreateAvdHomeViewModelState extends State<CreateAvdHomeViewModel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Этаж',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        CustomTextFieldWidget(
            controller: _flourEditingController,
            text: 'Этаж',
            password: false),
        const SizedBox(
          height: 4,
        ),
        const Text(
          'Площадь',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        CustomTextFieldWidget(
            controller: _squareEditingController,
            text: 'Площадь',
            password: false),
        const SizedBox(
          height: 12,
        ),
        const Text(
          'Ремонт',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        ExpansionTile(
          title: Text(_repair),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  _repair = 'Требуется';
                  setState(() {});
                },
                child: const ListTile(
                  title: Text('Требуется'),
                )),
            GestureDetector(
                onTap: () {
                  _repair = 'Евро';
                  setState(() {});
                },
                child: const ListTile(
                  title: Text('Евро'),
                )),
            GestureDetector(
                onTap: () {
                  _repair = 'Косметический';
                  setState(() {});
                },
                child: const ListTile(
                  title: Text('Косметический'),
                )),
            GestureDetector(
                onTap: () {
                  _repair = 'Дизайнерский';
                  setState(() {});
                },
                child: const ListTile(
                  title: Text('Дизайнерский'),
                )),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        const Text(
          'Право собственности',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        ExpansionTile(
          title: Text(_rules),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  _rules = 'Собсвенник';
                  setState(() {});
                },
                child: const ListTile(
                  title: Text('Собсвенник'),
                )),
            GestureDetector(
                onTap: () {
                  _rules = 'Посредник';
                  setState(() {});
                },
                child: const ListTile(
                  title: Text('Посредник'),
                )),
          ],
        ),


      ],
    );
  }
}
