import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_pet_nest/konstants.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //       image: AssetImage('assets/login_bg.jpg'), fit: BoxFit.cover),
        // ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 100,
              child: Center(
                  child: Image.asset(
                'assets/the_pet_nest.png',
                width: 163.73,
              )),
            ),
            Positioned(
                top: 174.45,
                child:
                    SvgPicture.asset('assets/images/welcome/hero_image.svg')),
            Positioned(
                top: 406,
                child: Text(
                  'Pet Grooming - Dog Training\nVet on Call',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kAppIconColor,
                      fontSize: 18,
                      height: 1,
                      fontWeight: FontWeight.w700),
                )),
            Positioned(
                top: 486.9,
                child: Text(
                  'We Connect Pet Parents with people\nwho`ll treat their Pets like family',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF232C63),
                      fontSize: 16,
                      height: 1,
                      fontWeight: FontWeight.w300),
                )),
            Positioned(
                top: 623,
                child: Row(
                  children: [
                    Container(
                      width: 165,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          border: Border.all(color: kAppIconColor)),
                      child: TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, kNavigationLogin),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: kAppIconColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                height: 1),
                          )),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: 165,
                      height: 50,
                      decoration: BoxDecoration(
                          color: kAppIconColor,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          border: Border.all(color: kAppIconColor)),
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Register',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                height: 1),
                          )),
                    )
                  ],
                )),
            Positioned(
                top: 707.86,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, kNavigationDashboard);
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(
                        fontSize: 16,
                        height: 1,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF232C63)),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}