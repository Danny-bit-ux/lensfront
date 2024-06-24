import 'package:flutter/material.dart';

import '../widgets/custom_textfield_widget.dart';

TextEditingController _brandEditingController = TextEditingController();
TextEditingController _modelEditingController = TextEditingController();
TextEditingController _gearsEditingController = TextEditingController();
TextEditingController _hpEditingController = TextEditingController();
TextEditingController _colorEditingController = TextEditingController();
TextEditingController _yearEditingController = TextEditingController();
TextEditingController _killometrsEditingController = TextEditingController();
String _state = 'Состояние';
String _drive = 'Тип привода';
String _transmission = 'Трансмиссия';
String _fuelSupply = 'Подача топлива';


class AdvMotoViewModel extends StatefulWidget {
  const AdvMotoViewModel({super.key});

  @override
  State<AdvMotoViewModel> createState() => _AdvMotoViewModelState();
}

class _AdvMotoViewModelState extends State<AdvMotoViewModel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Марка',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        CustomTextFieldWidget(
            controller: _brandEditingController,
            text: 'Марка',
            password: false),
        const SizedBox(
          height: 12,
        ),
        const Text(
          'Модель',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        CustomTextFieldWidget(
            controller: _modelEditingController,
            text: 'Модель',
            password: false),
        const SizedBox(
          height: 12,
        ),
        const Text(
          'Мощность',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        CustomTextFieldWidget(
            controller: _hpEditingController,
            text: 'Мощность',
            password: false),
        const SizedBox(
          height: 12,
        ),
        const Text(
          'Цвет',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        CustomTextFieldWidget(
            controller: _colorEditingController, text: 'Цвет', password: false),
        const SizedBox(
          height: 12,
        ),
        const Text(
          'Число передач',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        CustomTextFieldWidget(
            controller: _gearsEditingController, text: 'Число передач', password: false),
        const SizedBox(
          height: 12,
        ),
        const Text(
          'Пробег',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        CustomTextFieldWidget(
            controller: _killometrsEditingController,
            text: 'Пробег',
            password: false),
        const SizedBox(
          height: 12,
        ),
        const Text(
          'Год выпуска',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        CustomTextFieldWidget(
            controller: _yearEditingController,
            text: 'Год выпуска',
            password: false),
        const SizedBox(
          height: 12,
        ),
        const Text(
          'Состояние',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        ExpansionTile(
          title: Text(_state),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  _state = 'Новый';
                  setState(() {});
                },
                child: const ListTile(
                  title: Text('Новый'),
                )),
            GestureDetector(
                onTap: () {
                  _state = 'Б/у';
                  setState(() {});
                },
                child: const ListTile(
                  title: Text('Б/у'),
                )),
            GestureDetector(
                onTap: () {
                  _state = 'Требует ремонта';
                  setState(() {});
                },
                child: const ListTile(
                  title: Text('Требует ремонта'),
                )),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        const Text(
          'Тип привода',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        ExpansionTile(
          title: Text(_drive),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  _drive = 'Кардан';
                  setState(() {});
                },
                child: const ListTile(
                  title: Text('Кардан'),
                )),
            GestureDetector(
                onTap: () {
                  _drive = 'Цепь';
                  setState(() {});
                },
                child: const ListTile(
                  title: Text('Цепь'),
                )),
            GestureDetector(
                onTap: () {
                  _drive = 'Ремень';
                  setState(() {});
                },
                child: const ListTile(
                  title: Text('Ремень'),
                )),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        const Text(
          'Трансмиссия',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        ExpansionTile(
          title: Text(_transmission),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  _transmission = 'Автоматическая';
                  setState(() {});
                },
                child: const ListTile(
                  title: Text('Автоматическая'),
                )),
            GestureDetector(
                onTap: () {
                  _transmission = 'Механическаяя';
                  setState(() {});
                },
                child: const ListTile(
                  title: Text('Механическаяя'),
                )),
            GestureDetector(
                onTap: () {
                  _transmission = 'Вариатор';
                  setState(() {});
                },
                child: const ListTile(
                  title: Text('Вариатор'),
                )),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        const Text(
          'Подача топлива',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        ExpansionTile(
          title: Text(_fuelSupply),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  _fuelSupply = 'Карбюратор';
                  setState(() {});
                },
                child: const ListTile(
                  title: Text('Карбюратор'),
                )),
            GestureDetector(
                onTap: () {
                  _fuelSupply = 'Инжектор';
                  setState(() {});
                },
                child: const ListTile(
                  title: Text('Инжектор'),
                )),
          ],
        ),
      ],
    );
  }
}
