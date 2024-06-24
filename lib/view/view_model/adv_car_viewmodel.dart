import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/fill_adverb_controller.dart';
import '../widgets/custom_textfield_widget.dart';


TextEditingController _brandEditingController = TextEditingController();
TextEditingController _modelEditingController = TextEditingController();
TextEditingController _motorEditingController = TextEditingController();
TextEditingController _hpEditingController = TextEditingController();
TextEditingController _nmEditingController = TextEditingController();
TextEditingController _colorEditingController = TextEditingController();
TextEditingController _yearEditingController = TextEditingController();
TextEditingController _killometrsEditingController = TextEditingController();
String _state = 'Состояние';
String _drive = 'Тип привода';
String _transmission = 'Трансмиссия';
String _fuelSupply = 'Подача топлива';
class CreateCarViewModel extends StatefulWidget {
  const CreateCarViewModel({super.key});

  @override
  State<CreateCarViewModel> createState() => _CreateCarViewModelState();
}

class _CreateCarViewModelState extends State<CreateCarViewModel> {
  @override
  Widget build(BuildContext context) {
    final adverbModel = context.read<FillAdverbModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Марка авто',
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
            onChange: (_) {
              adverbModel.adverbModel.brand = _brandEditingController.text;
            },
            text: 'Марка авто',
            password: false),
        const SizedBox(
          height: 12,
        ),
        const Text(
          'Модель авто',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        CustomTextFieldWidget(
            onChange: (_) {
              adverbModel.adverbModel.model = _modelEditingController.text;
            },
            controller: _modelEditingController,
            text: 'Модель авто',
            password: false),
        const SizedBox(
          height: 12,
        ),
        const Text(
          'Название мотора (необязательно)',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        CustomTextFieldWidget(
            onChange: (_) {
              adverbModel.adverbModel.engine = _motorEditingController.text;
            },
            controller: _motorEditingController,
            text: 'Название мотора',
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
            onChange: (_) {
              adverbModel.adverbModel.hp = _hpEditingController.text;
            },
            controller: _hpEditingController,
            text: 'Мощность',
            password: false),
        const SizedBox(
          height: 12,
        ),
        const Text(
          'Крутящий момент (необязательно)',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        CustomTextFieldWidget(
            onChange: (_) {
              adverbModel.adverbModel.nm = _nmEditingController.text;
            },
            controller: _nmEditingController,
            text: 'Крутящий момент (N * m)',
            password: false),
        const SizedBox(
          height: 12,
        ),
        const Text(
          'Цвет авто',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        CustomTextFieldWidget(
            onChange: (_) {
              adverbModel.adverbModel.color = _colorEditingController.text;
            },
            controller: _colorEditingController, text: 'Цвет', password: false),
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
            onChange: (_) {
              adverbModel.adverbModel.killometrs = _killometrsEditingController.text;
            },
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
            onChange: (_) {
              adverbModel.adverbModel.year = _yearEditingController.text;
            },
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
                    adverbModel.adverbModel.state = _state;
                  setState(() {});
                },
                child: const ListTile(
                  title: Text('Новый'),
                )),
            GestureDetector(
                onTap: () {
                  _state = 'Б/у';
                  adverbModel.adverbModel.state = _state;
                  setState(() {});
                },
                child: const ListTile(
                  title: Text('Б/у'),
                )),
            GestureDetector(
                onTap: () {
                  _state = 'Требует ремонта';
                  adverbModel.adverbModel.state = _state;
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
                  _drive = 'Полный';
                  adverbModel.adverbModel.drive_type = _drive;
                  setState(() {});
                },
                child: const ListTile(
                  title: Text('Полный'),
                )),
            GestureDetector(
                onTap: () {
                  _drive = 'Передний';
                  adverbModel.adverbModel.drive_type = _drive;
                  setState(() {});
                },
                child: const ListTile(
                  title: Text('Передний'),
                )),
            GestureDetector(
                onTap: () {
                  _drive = 'Задний';
                  adverbModel.adverbModel.drive_type = _drive;
                  setState(() {});
                },
                child: const ListTile(
                  title: Text('Задний'),
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
                  adverbModel.adverbModel.transmission = _transmission;
                  setState(() {});
                },
                child: const ListTile(
                  title: Text('Автоматическая'),
                )),
            GestureDetector(
                onTap: () {
                  _transmission = 'Механическая';
                  adverbModel.adverbModel.transmission = _transmission;
                  setState(() {});
                },
                child: const ListTile(
                  title: Text('Механическая'),
                )),
            GestureDetector(
                onTap: () {
                  _transmission = 'Вариатор';
                  adverbModel.adverbModel.transmission = _transmission;
                  setState(() {});
                },
                child: const ListTile(
                  title: Text('Вариатор'),
                )),
            GestureDetector(
                onTap: () {
                  _transmission = 'Робот';
                  adverbModel.adverbModel.transmission = _transmission;
                  setState(() {});
                },
                child: const ListTile(
                  title: Text('Робот'),
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
                  adverbModel.adverbModel.fuel_supply = _fuelSupply;
                  setState(() {});
                },
                child: const ListTile(
                  title: Text('Карбюратор'),
                )),
            GestureDetector(
                onTap: () {
                  _fuelSupply = 'Инжектор';
                  adverbModel.adverbModel.fuel_supply = _fuelSupply;
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
