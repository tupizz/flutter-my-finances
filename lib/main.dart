import 'package:flutter/material.dart';

import './widgets/scaffold_home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minhas Finanças',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.orangeAccent,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
