import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import './ct_page.dart';
import './cxr_page.dart';

class Tabs_screen extends StatefulWidget {
  @override
  _Tabs_screenState createState() => _Tabs_screenState();
}

class _Tabs_screenState extends State<Tabs_screen> {
  List<Map<String, Object>> pages = [
    {'page': 'CXR_Screen', 'body': CXR_page()},
    {'page': 'CT_Screen', 'body': CTPage()}
  ];

  int _selectedPageindex = 0;

  void _selectPage(int index) {
    EasyLoading.dismiss();
    setState(() {
      _selectedPageindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pages[_selectedPageindex]['page']),
        centerTitle: true,
      ),
      body: pages[_selectedPageindex]['body'],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.filter_1_rounded),
              label: 'Cxr Screen',
              backgroundColor: Colors.purple),
          BottomNavigationBarItem(
              icon: Icon(Icons.filter_2_rounded),
              label: 'Ct Screen',
              backgroundColor: Colors.purple)
        ],
        onTap: _selectPage,
        currentIndex: _selectedPageindex,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        elevation: 5,
      ),
    );
  }
}
