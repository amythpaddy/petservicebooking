import 'package:flutter/material.dart';
import 'package:the_pet_nest/dashboard/dashboard.dart';
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
          fontFamily: 'Poppins',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/login': (context) => MobileLogin(),
          '/dashboard': (context) => Dashboard()
        },
        initialRoute: '/dashboard');
    // home: MobileLogin());
  }
}
