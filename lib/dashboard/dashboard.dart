import 'package:flutter/material.dart';
import 'package:the_pet_nest/bookings/bookings.dart';
import 'package:the_pet_nest/dashboard/component/BottomNavigationIcons.dart';
import 'package:the_pet_nest/home/home.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

enum BottomNavigationOptions { HOME, BOOKING, INVITE, ME }

class _DashboardState extends State<Dashboard> {
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
      backgroundColor: Color(0xFFE5E5E5),
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        title: Center(
          child: Container(
              width: 150, child: Image.asset('assets/the_pet_nest.png')),
        ),
        leading: IconButton(
          icon: Icon(Icons.accessible),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 50,
              height: 50,
              child: Icon(
                Icons.person_add_alt,
                color: Colors.orangeAccent,
                size: 30,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Color.fromARGB(70, 255, 191, 71)),
            ),
          )
        ],
      ),
      drawer: Drawer(),
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
                            fillColor: Colors.orange,
                            onPressed: () {},
                            child: Icon(Icons.add_a_photo_sharp),
                          ),
                        ),
                      ),
                      Container(
                        width: size.width,
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            BottomNavigationIcons(
                              onPressed: () {
                                setState(() {
                                  navigationOptions =
                                      BottomNavigationOptions.HOME;
                                });
                              },
                              icon: Icons.home_filled,
                              text: 'Home',
                            ),
                            BottomNavigationIcons(
                              onPressed: () {
                                setState(() {
                                  navigationOptions =
                                      BottomNavigationOptions.BOOKING;
                                });
                              },
                              icon: Icons.list_alt,
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
                              icon: Icons.person_add_alt,
                              text: 'Invite',
                            ),
                            BottomNavigationIcons(
                              onPressed: () {
                                setState(() {
                                  navigationOptions =
                                      BottomNavigationOptions.ME;
                                });
                              },
                              icon: Icons.person_outline,
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
