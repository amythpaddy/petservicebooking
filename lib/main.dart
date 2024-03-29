import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_pet_nest/addressBook/addEditAddress.dart';
import 'package:the_pet_nest/addressBook/addressList.dart';
import 'package:the_pet_nest/bookings/bookingDetail.dart';
import 'package:the_pet_nest/bookings/feedback/feedback.dart';
import 'package:the_pet_nest/dashboard/dashboard.dart';
import 'package:the_pet_nest/funnels/petGrooming/petGrooming.dart';
import 'package:the_pet_nest/funnels/petGrooming/petGroomingDetail.dart';
import 'package:the_pet_nest/funnels/petTraining/petTrainingDetail.dart';
import 'package:the_pet_nest/funnels/petTraining/petTrarining.dart';
import 'package:the_pet_nest/funnels/vetFunnel/vetFunnel.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/dataAccessors.dart';
import 'package:the_pet_nest/konstants/flavorValues/stagingValues.dart';
import 'package:the_pet_nest/konstants/paths.dart';
import 'package:the_pet_nest/messaging/messaging.dart';
import 'package:the_pet_nest/profiles/petProfile/addPetProfile.dart';
import 'package:the_pet_nest/profiles/petProfile/editPetProfile.dart';
import 'package:the_pet_nest/profiles/petProfile/petProfile.dart';
import 'package:the_pet_nest/profiles/userProfile/editProfile.dart';
import 'package:the_pet_nest/profiles/userProfile/userProfile.dart';
import 'package:the_pet_nest/sidebar/coupons.dart';
import 'package:the_pet_nest/sidebar/referAndEarn.dart';
import 'package:the_pet_nest/support/support.dart';
import 'package:the_pet_nest/welcome/login/login.dart';
import 'package:the_pet_nest/welcome/otp/otp.dart';
import 'package:the_pet_nest/welcome/register/register.dart';
import 'package:the_pet_nest/welcome/welcome.dart';

import 'funnels/vetFunnel/vetDetail.dart';

late SharedPreferences prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig(
      name: "DEV",
      color: Colors.red,
      location: BannerLocation.bottomStart,
      variables: stagingValues);
  await FlutterConfig.loadEnvVariables();
  prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp(){
// OneSignal.shared.setLogLevel(OSLogLevel.info, OSLogLevel.info);
OneSignal.shared.setAppId(FlutterConfig.get('ONE_SIGNAL_KEY'));
// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
});
  }
  @override
  Widget build(BuildContext context) {
    print('token, ${prefs.getString(kDataToken)}');
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
          kNavigationFeedback: (context) => PetHeroFeedback(),
          kNavigationUserprofile: (context) => UserProfile(),
          kNavigationEditUserprofile: (context) => EditUserProfile(),
          kNavigationPetProfile: (context) => PetProfile(),
          kNavigationEditPetProfile: (context) => EditPetProfile(),
          kNavigationAddPetProfile: (context) => AddPetProfile(),
          kNavigationSupport: (context) => Support(),
          kNavigationPetTrainingFunnel: (context) => PetTrainingService(),
          kNavigationPetTrainingDetail: (context) => PetTrainingDetail(),
          kNavigationPetGroomingFunnel: (context) => PetGroomingService(),
          kNavigationPetGroomingDetail: (context) => PetGroomingDetail(),
          kNavigationVetFunnel: (context) => VetService(),
          kNavigationVetDetail: (context) => VetDetail(),
          kNavigationAddressBook: (context) => AddressList(),
          kNavigationAddEditAddressBook: (context) => AddEditMap(),
          kNavigationMessaging: (context) => Messaging(),
          kNavigationBookingDetailsPage: (context) => BookingDetail(),
          kNavigationReferAndEarn: (context) => ReferAndEarn(),
          kNavigationViewCoupons: (context) => Coupons()
        },
        // initialRoute: kNavigationMessaging);
        initialRoute: (prefs.getString(kDataToken) ?? '') == ''
            ? kNavigationWelcome
            : kNavigationDashboard);
    // home: MobileLogin());
  }
}
