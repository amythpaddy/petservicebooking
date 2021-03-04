import 'package:flutter/material.dart';
import 'package:the_pet_nest/home/home.dart';
import 'package:the_pet_nest/login/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        routes: {
          '/login': (context) => MobileLogin(),
          '/home': (context) => Home()
        },
        // initialRoute: '/login',
        home: MobileLogin());
  }
}
