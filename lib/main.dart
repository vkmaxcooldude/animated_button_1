import 'package:animated_button_1/animated_button.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: AnimatedButton(
            animationDuration: Duration(milliseconds: 1000),
            initialText: "Confirm",
            finalText: "Submitted",
            iconData: Icons.check,
            iconSize: 32.0,
            buttonStyle: ButtonStyle(
              elevation: 20.0,
              primaryColor: Color(0xff028f1d),
              secondaryColor: Colors.white,
              initialTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
              finalTextStyle: TextStyle(
                color: Color(0xff028f1d),
                fontSize: 20.0,
              ),
              borderRadius: 10.0,
            ),
          ),
        ),
      ),
    );
  }
}
