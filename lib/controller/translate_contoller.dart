import 'package:flutter/cupertino.dart';

import '../model/translate_model.dart';
import '../translates/ru_tr.dart';


class TranslateController extends ChangeNotifier {
  TranslateModel translateModel = ruTranslate;
  void changeLanguage(TranslateModel language) {
    translateModel = language;
    notifyListeners();
  }
}