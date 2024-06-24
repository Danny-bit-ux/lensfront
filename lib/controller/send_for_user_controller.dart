import 'package:flutter/cupertino.dart';

class SendForUserController extends ChangeNotifier {
  var skills;
  var education;
  var experience;
  var about_me;
  var client_visiting;
  void editSkills(String newSkills) {
    skills = newSkills;
    notifyListeners();
  }
  void editEducation(String newEducation) {
    education = newEducation;
    notifyListeners();
  }
  void editExperience(String newExperience) {
    experience = newExperience;
    notifyListeners();
  }
  void editAboutMe(String newAboutMe) {
    about_me = newAboutMe;
    notifyListeners();
  }
  void editClientVisiting(String newClientVisiting) {
    client_visiting = newClientVisiting;
    notifyListeners();
  }
}