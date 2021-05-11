import 'package:flutter/material.dart';
import 'package:the_pet_nest/bookings/feedback/feedback.dart';
import 'package:the_pet_nest/dashboard/dashboard.dart';
import 'package:the_pet_nest/konstants/paths.dart';
import 'package:the_pet_nest/profiles/userProfile/editProfile.dart';
import 'package:the_pet_nest/profiles/userProfile/userProfile.dart';
import 'package:the_pet_nest/welcome/login/login.dart';
import 'package:the_pet_nest/welcome/otp/otp.dart';
import 'package:the_pet_nest/welcome/register/register.dart';
import 'package:the_pet_nest/welcome/welcome.dart';

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
          visualDensity: VisualDensity.standard,
          cardTheme: CardTheme(shadowColor: Color(0x0c000000)),
        ),
        routes: {
          kNavigationLogin: (context) => MobileLogin(),
          kNavigationDashboard: (context) => Dashboard(),
          kNavigationWelcome: (context) => Welcome(),
          kNavigationOtp: (context) => OtpEntry(),
          kNavigationRegister: (context) => Register(),
          kNavigationFeedback: (context) => PetheroFeedback(),
          kNavigationUserprofile: (context) => UserProfile(),
          kNavigationEditUserprofile:(context)=> EditUserProfile()
        },
        initialRoute: kNavigationWelcome);
    // home: MobileLogin());
  }
}
