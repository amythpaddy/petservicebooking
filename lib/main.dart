import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:the_pet_nest/bookings/feedback/feedback.dart';
import 'package:the_pet_nest/dashboard/dashboard.dart';
import 'package:the_pet_nest/funnels/petTraining/petTrarining.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/flavorValues/stagingValues.dart';
import 'package:the_pet_nest/konstants/paths.dart';
import 'package:the_pet_nest/profiles/petProfile/addPetProfile.dart';
import 'package:the_pet_nest/profiles/petProfile/editPetProfile.dart';
import 'package:the_pet_nest/profiles/petProfile/petProfile.dart';
import 'package:the_pet_nest/profiles/userProfile/editProfile.dart';
import 'package:the_pet_nest/profiles/userProfile/userProfile.dart';
import 'package:the_pet_nest/support/support.dart';
import 'package:the_pet_nest/welcome/login/login.dart';
import 'package:the_pet_nest/welcome/otp/otp.dart';
import 'package:the_pet_nest/welcome/register/register.dart';
import 'package:the_pet_nest/welcome/welcome.dart';

void main() {
  FlavorConfig(
      name: "DEV",
      color: Colors.red,
      location: BannerLocation.bottomStart,
      variables: stagingValues);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primarySwatch: MaterialColor(
              0xFFFF7717,
              <int, Color>{
                50: Color(0xFFffa84c),
                100: Color(0xFFFFA543),
                200: Color(0xFFFA9D37),
                300: Color(0xFFFA8D2D),
                400: Color(0xFFFF7717),
                500: Color(0xFFFF7717),
                600: Color(0xFFFF7717),
                700: Color(0xFFFF7717),
                800: Color(0xFFFF7717),
                900: Color(0xFFc54700),
              },
            ),
            primaryColor: kAppIconColor,
            fontFamily: 'Poppins',
            visualDensity: VisualDensity.standard,
            cardTheme: CardTheme(shadowColor: Color(0x0c000000)),
            canvasColor: Colors.white,
            bottomSheetTheme:
                BottomSheetThemeData(backgroundColor: Colors.transparent)),
        routes: {
          kNavigationLogin: (context) => MobileLogin(),
          kNavigationDashboard: (context) => Dashboard(),
          kNavigationWelcome: (context) => Welcome(),
          kNavigationOtp: (context) => OtpEntry(),
          kNavigationRegister: (context) => Register(),
          kNavigationFeedback: (context) => PetheroFeedback(),
          kNavigationUserprofile: (context) => UserProfile(),
          kNavigationEditUserprofile: (context) => EditUserProfile(),
          kNavigationPetProfile: (context) => PetProfile(),
          kNavigationEditPetProfile: (context) => EditPetProfile(),
          kNavigationAddPetProfile: (context) => AddPetProfile(),
          kNavigationSupport: (context) => Support(),
          kNavigationPetTrainingFunnel: (context) => PetTrainingService()
        },
        initialRoute: kNavigationWelcome);
    // home: MobileLogin());
  }
}
