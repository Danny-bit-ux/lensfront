import 'package:flutter/cupertino.dart';
//TextEditingController _brandEditingController = TextEditingController();
// TextEditingController _modelEditingController = TextEditingController();
// TextEditingController _motorEditingController = TextEditingController();
// TextEditingController _hpEditingController = TextEditingController();
// TextEditingController _nmEditingController = TextEditingController();
// TextEditingController _colorEditingController = TextEditingController();
// TextEditingController _yearEditingController = TextEditingController();
// TextEditingController _killometrsEditingController = TextEditingController();
// String _state = 'Состояние';
// String _drive = 'Тип привода';
// String _transmission = 'Трансмиссия';
// String _fuelSupply = 'Подача топлива';
class AdvVisualCarModel extends StatelessWidget {
  final String brand;
  final String model;
  final String motor;
  final String hp;
  final String nm;
  final String color;
  final String year;
  final String killometers;
  final String state;
  final String drive;
  final String transmission;
  final String fuelSupply;
  const AdvVisualCarModel({super.key,
  required this.brand,
  required this.color,
  required this.drive,
  required this.fuelSupply,
  required this.hp,
  required this.killometers,
  required this.model,
  required this.motor,
  required this.nm,
  required this.state,
  required this.transmission,
  required this.year});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Бренд: $brand'),
        SizedBox(height: 8,),
        Text('Модель: $model'),
        SizedBox(height: 8,),
        Text('Мотор: $motor'),
        SizedBox(height: 8,),
        Text('Цвет: $color'),
        SizedBox(height: 8,),
        Text('Мощность: $hp'),
        SizedBox(height: 8,)
      ],
    );
  }
}
