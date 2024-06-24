import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main/ads/avito_list_view.dart';
import 'main/chat/chat_list_view.dart';
import 'main/home_view.dart';
import 'main/select_post_type.dart';
import 'main/services/services_view.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ServicesView(),
    SelectPostType(),
    AvitoListView(auth: true,),
    ChatListView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor:  const Color(0xffD0D4B1),
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: "Главная",
          ),
          const BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.briefcase),
            label: "Услуги",
          ),
          BottomNavigationBarItem(
            icon: Container(decoration: BoxDecoration(
              color:  const Color(0xffD0D4B1),
              borderRadius: BorderRadius.circular(100),
            ),child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(CupertinoIcons.add,color: Colors.white),
            ),),
            label: "Создать",
          ),
          const BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.doc_append),
            label: "Объявления",
          ),
          const BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.bubble_left),
            label: "Чат",
          ),
        ],
      ),
    );
  }
}