// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../ServerRoutes.dart';

class EditProfileController extends ChangeNotifier {
  Dio dio = Dio();
  var userName;
  var userEmail;
  var userCity;
  var userCategory;
  var userDateOfBurn;
  var userSkills;
  var userEducation;
  var userExperience;
  var userAboutMe;
  var userClientVisiting;
  void setParameters({
    required name,
    required email,
    required city,
    required category,
    required dateOfBurn,
    required skills,
    required education,
    required experience,
    required aboutMe,
    required clientVisiting,
  }) {
    userName = name;
    userEmail = email;
    userCity = city;
    userCategory = category;
    userDateOfBurn = dateOfBurn;
    userSkills = skills;
    userEducation = education;
    userExperience = experience;
    userAboutMe = aboutMe;
    userClientVisiting = clientVisiting;
    notifyListeners();
  }
  Future<void> updateProfileData(uid) async {
    setParameters(name: userName, email: userEmail, city: userCity, category: '', dateOfBurn: userDateOfBurn, skills: userSkills, education: userEducation, experience: userExperience, aboutMe: userAboutMe, clientVisiting: userClientVisiting);
    dio.post('${ServerRoutes.host}/updateuserdata',
    data: {
      'uid': uid.toString(),
      'name': userName,
      'email': userEmail,
      'skills': userSkills,
      'education': userEducation,
      'experience': userExperience,
      'city': userCity,
      'dateOfBurn': userDateOfBurn,
      'aboutMe': userAboutMe,
      'category': userCategory,
      'clientVisiting': userClientVisiting,
    });

  }
}
