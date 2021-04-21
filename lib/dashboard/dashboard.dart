import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_pet_nest/bookings/bookings.dart';
import 'package:the_pet_nest/dashboard/component/BottomNavigationIcons.dart';
import 'package:the_pet_nest/home/home.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/sidebar/sidebar.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

enum BottomNavigationOptions { HOME, BOOKING, INVITE, ME }
const Color activeColor = Color(0xFFFF7717);
const Color inactiveColor = Color(0xFFB6B7B9);

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  BottomNavigationOptions navigationOptions = BottomNavigationOptions.HOME;
  Widget fragment;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    switch (navigationOptions) {
      case BottomNavigationOptions.HOME:
        fragment = Home();
        break;
      case BottomNavigationOptions.BOOKING:
        fragment = Bookings();
        break;
    }
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kAppBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: kAppBackgroundColor,
        elevation: 0,
        title: Center(
          child: Container(
              width: 150, child: Image.asset('assets/the_pet_nest.png')),
        ),
        leading: Container(
          child: TextButton(
            child: SvgPicture.asset(
              'assets/images/hamburger.svg',
              color: Colors.black87,
            ),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 50,
              height: 50,
              child: Image.asset('assets/images/avatar.png'),
            ),
          )
        ],
      ),
      drawer: Sidebar(),
      body: SafeArea(
        child: Stack(
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
                        heightFactor: 0.1,
                        child: Container(
                          height: 100,
                          width: 100,
                          child: RawMaterialButton(
                            shape: new CircleBorder(),
                            fillColor: Colors.white,
                            onPressed: () {},
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
                                      BottomNavigationOptions.INVITE;
                                });
                              },
                              icon: navigationOptions ==
                                      BottomNavigationOptions.INVITE
                                  ? 'assets/images/bottomNavigation/invite_fill_icon.svg'
                                  : 'assets/images/bottomNavigation/invite_icon.svg',
                              color: navigationOptions ==
                                      BottomNavigationOptions.INVITE
                                  ? activeColor
                                  : inactiveColor,
                              text: 'Invite',
                            ),
                            BottomNavigationIcons(
                              onPressed: () {
                                setState(() {
                                  navigationOptions =
                                      BottomNavigationOptions.ME;
                                });
                              },
                              icon: navigationOptions ==
                                      BottomNavigationOptions.ME
                                  ? 'assets/images/bottomNavigation/me_fill_icon.svg'
                                  : 'assets/images/bottomNavigation/me_icon.svg',
                              color: navigationOptions ==
                                      BottomNavigationOptions.ME
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
      ..moveTo(0, 0)
      ..lineTo(size.width * .37, 0)
      ..arcToPoint(Offset(size.width * .63, 0),
          radius: Radius.circular(5.0), clockwise: false)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);

    canvas.drawShadow(path, Colors.black26, 50, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
