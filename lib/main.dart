import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              // cada um desses é um estilo de texto que eu crio para replicar no aplicativo
              subtitle: TextStyle(
                fontFamily: 'Quicksand',
                color: Colors.grey,
                fontSize: 14,
              ),
              // cada um desses é um estilo de texto que eu crio para replicar no aplicativo
              title: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 18,
                wordSpacing: 3,
              ),
              button: TextStyle(
                color: Colors.white,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 16,
                ),
              ),
        ),
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')],
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
