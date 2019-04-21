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
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: AnimatedButton(
            onTap: (){
              print("Job is done!");
            },
            animationDuration: const Duration(milliseconds: 2000),
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
