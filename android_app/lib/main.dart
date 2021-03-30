import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import './views/tabs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.purple, accentColor: Colors.amber),
      home: Tabs_screen(),
      builder: EasyLoading.init(),
    );
  }
}
