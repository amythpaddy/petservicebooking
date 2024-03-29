import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_pet_nest/bookings/bookings.dart';
import 'package:the_pet_nest/dashboard/component/BottomNavigationIcons.dart';
import 'package:the_pet_nest/dashboard/component/addPetPopup/addPetPopup.dart';
import 'package:the_pet_nest/home/home.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/dataAccessors.dart';
import 'package:the_pet_nest/konstants/styles.dart';
import 'package:the_pet_nest/messaging/messaging.dart';
import 'package:the_pet_nest/profiles/bloc/userProfile/userProfileBloc.dart';
import 'package:the_pet_nest/profiles/bloc/userProfile/userProfileState.dart';
import 'package:the_pet_nest/profiles/userProfile/userProfile.dart';
import 'package:the_pet_nest/sidebar/component/welcome/welcomeModal.dart';
import 'package:the_pet_nest/sidebar/sidebar.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

enum BottomNavigationOptions { HOME, BOOKING, MESSAGE, ME }
const Color activeColor = Color(0xFFFF7717);
const Color inactiveColor = Color(0xFFB6B7B9);

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  BottomNavigationOptions navigationOptions = BottomNavigationOptions.HOME;
  late SharedPreferences prefs;
  late Widget fragment;

  @override
  void initState() {
    initSharedPreferences();
  }

  void initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  Widget appBarTitle = Text('ThePetNest', style: kAppBarTitleStyle);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    switch (navigationOptions) {
      case BottomNavigationOptions.HOME:
        fragment = Home();
        appBarTitle = Container(
            width: 150,
            child: Image.asset(
              'assets/the_pet_nest.png',
              height: 32.67,
              cacheHeight: 100,
              cacheWidth: 400,
            ));
        break;
      case BottomNavigationOptions.BOOKING:
        fragment = Bookings();
        appBarTitle = Container(
            width: 150,
            child: Image.asset(
              'assets/the_pet_nest.png',
              height: 32.67,
              cacheHeight: 100,
              cacheWidth: 400,
            ));
        break;
      case BottomNavigationOptions.ME:
        if (prefs.getString(kDataToken) != null) {
          fragment = UserProfile();
          appBarTitle = Text('My Profile', style: kAppBarTitleStyle);
        } else {
          appBarTitle = Text('My Profile', style: kAppBarTitleStyle);
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => Theme(
              data: ThemeData(canvasColor: Colors.transparent),
              child: FractionallySizedBox(
                heightFactor: 1,
                child: WelcomeModal(),
              ),
            ),
          );
        }
        break;
      case BottomNavigationOptions.MESSAGE:
        fragment = Messaging();
        appBarTitle = Text('Messages', style: kAppBarTitleStyle);
        break;
      default:
        appBarTitle = Container(
            width: 150,
            child: Image.asset(
              'assets/the_pet_nest.png',
              height: 32.67,
              cacheHeight: 100,
              cacheWidth: 400,
            ));
    }
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kAppBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: navigationOptions == BottomNavigationOptions.MESSAGE ||
                navigationOptions == BottomNavigationOptions.ME
            ? kAppBackgroundAltGray
            : kAppBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: appBarTitle,
        leading: Container(
          child: TextButton(
            child: SvgPicture.asset(
              'assets/images/hamburger.svg',
              color: Colors.black87,
            ),
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
          ),
        ),
        actions: [
          navigationOptions == BottomNavigationOptions.MESSAGE ||
                  navigationOptions == BottomNavigationOptions.ME
              ? Text('')
              : TextButton(
                  onPressed: () {
                    String token = prefs.getString(kDataToken) ?? '';
                    if (token.isNotEmpty)
                      setState(() {
                        navigationOptions = BottomNavigationOptions.ME;
                      });
                  },
                  child: BlocProvider(
                    create: (_) => UserProfileBloc(UserProfileState()),
                    child: BlocBuilder<UserProfileBloc, UserProfileState>(
                      builder: (blocContext, state) {
                        if (state.imageAddress.isEmpty) {
                          return Container(
                              width: 50,
                              height: 50,
                              child: Image.asset('assets/images/avatar.png'));
                        } else {
                          return ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.network(
                                state.imageAddress,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null)
                                    return child;
                                  else {
                                    return Container(
                                        width: 50,
                                        height: 50,
                                        child: Image.asset(
                                            'assets/images/avatar.png'));
                                  }
                                },
                                height: 45,
                                width: 45,
                                fit: BoxFit.fitWidth,
                              ));
                        }
                      },
                    ),
                  ),
                ),
        ],
      ),
      drawer: Sidebar(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          fragment,
          Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: size.width,
                height: 80,
                child: Stack(
                  children: [
                    CustomPaint(
                      size: Size(size.width, 80),
                      painter: BottomNavigationCustomPainter(),
                    ),
                    Center(
                      heightFactor: 0.15,
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: kAppIconColor.withOpacity(.1),
                              spreadRadius: 4,
                              blurRadius: 10,
                              // offset: Offset(3, 3),
                            ),
                          ],
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(500),
                        ),
                        child: RawMaterialButton(
                          shape: new CircleBorder(),
                          fillColor: Colors.white,
                          onPressed: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => Theme(
                                data:
                                    ThemeData(canvasColor: Colors.transparent),
                                child: FractionallySizedBox(
                                  heightFactor: 1,
                                  child: AddPetPopup(),
                                ),
                              ),
                            );
                          },
                          child: SvgPicture.asset(
                              'assets/images/pet_paw_icon.svg'),
                        ),
                      ),
                    ),
                    Container(
                      width: size.width,
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          BottomNavigationIcons(
                            onPressed: () {
                              setState(() {
                                navigationOptions =
                                    BottomNavigationOptions.HOME;
                              });
                            },
                            icon: navigationOptions ==
                                    BottomNavigationOptions.HOME
                                ? 'assets/images/bottomNavigation/home_fill_icon.svg'
                                : 'assets/images/bottomNavigation/home_icon.svg',
                            color: navigationOptions ==
                                    BottomNavigationOptions.HOME
                                ? activeColor
                                : inactiveColor,
                            text: 'Home',
                          ),
                          BottomNavigationIcons(
                            onPressed: () {
                              setState(() {
                                navigationOptions =
                                    BottomNavigationOptions.BOOKING;
                              });
                            },
                            icon: navigationOptions ==
                                    BottomNavigationOptions.BOOKING
                                ? 'assets/images/bottomNavigation/booking_fill_icon.svg'
                                : 'assets/images/bottomNavigation/booking_icon.svg',
                            color: navigationOptions ==
                                    BottomNavigationOptions.BOOKING
                                ? activeColor
                                : inactiveColor,
                            text: 'Booking',
                          ),
                          SizedBox(
                            width: size.width * .2,
                          ),
                          BottomNavigationIcons(
                            onPressed: () {
                              setState(() {
                                navigationOptions =
                                    BottomNavigationOptions.MESSAGE;
                              });
                            },
                            icon: navigationOptions ==
                                    BottomNavigationOptions.MESSAGE
                                ? 'assets/images/bottomNavigation/message_fill_icon.svg'
                                : 'assets/images/bottomNavigation/message_icon.svg',
                            color: navigationOptions ==
                                    BottomNavigationOptions.MESSAGE
                                ? activeColor
                                : inactiveColor,
                            text: 'Messages',
                          ),
                          BottomNavigationIcons(
                            onPressed: () {
                              if ((prefs.getString(kDataToken) ?? '')
                                  .isNotEmpty)
                                setState(() {
                                  navigationOptions =
                                      BottomNavigationOptions.ME;
                                });
                            },
                            icon: navigationOptions ==
                                    BottomNavigationOptions.ME
                                ? 'assets/images/bottomNavigation/me_fill_icon.svg'
                                : 'assets/images/bottomNavigation/me_icon.svg',
                            color:
                                navigationOptions == BottomNavigationOptions.ME
                                    ? activeColor
                                    : inactiveColor,
                            text: 'Me',
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class BottomNavigationCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path()
      ..moveTo(0, size.height * .25)
      ..arcToPoint(Offset(size.width * .05, 0),
          radius: Radius.circular(25.0), clockwise: true)
      ..lineTo(size.width * .35, 0)
      ..arcToPoint(Offset(size.width * .40, size.height * .25),
          radius: Radius.circular(25.0), clockwise: true)
      ..arcToPoint(Offset(size.width * .60, size.height * .25),
          radius: Radius.circular(57.0), clockwise: false)
      ..arcToPoint(Offset(size.width * .65, 0),
          radius: Radius.circular(25.0), clockwise: true)
      ..lineTo(size.width * .95, 0)
      ..arcToPoint(Offset(size.width, size.height * .25),
          radius: Radius.circular(25.0), clockwise: true)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);

    canvas.drawShadow(path, kAppIconColor, 3, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
