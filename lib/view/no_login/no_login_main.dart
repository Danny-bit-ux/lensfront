import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';


import '../../domain/user/auth/create_user.dart';
import '../../domain/user/get_user_profile.dart';
import '../main/ads/avito_list_view.dart';
import '../main_view.dart';
import 'no_login_chat.dart';
import 'no_login_home.dart';
import 'no_login_services.dart';
class NoLoginMainScreen extends StatefulWidget {
  const NoLoginMainScreen({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<NoLoginMainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    NoLoginHomeScreen(),
    NoLoginServicesView(),
    AvitoListView(auth: false,),
    NoLoginChat(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
  final getProfile = context.read<GetUserProfile>();
    Future.delayed(const Duration(milliseconds: 10), () async {
      FlutterSecureStorage flutterSecureStorage = const FlutterSecureStorage();
      final String? getUid = await flutterSecureStorage.read(key: 'uid');
      if (getUid != null) {
        uid = getUid;
        await getProfile.getUserProfile(getUid);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainView()),
                (route) => false);
      }
    });
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: "Главная",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.briefcase),
            label: "Услуги",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.doc_append),
            label: "Объявления",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.bubble_left),
            label: "Чат",
          ),
        ],
      ),
    );
  }
}