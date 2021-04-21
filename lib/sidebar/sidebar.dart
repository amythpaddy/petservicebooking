import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_pet_nest/konstants/paths.dart';

class Sidebar extends StatelessWidget {
  bool loggedIn = false;
  Future<SharedPreferences> pref = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DrawerHeader(
            child: Row(
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    margin: EdgeInsets.only(right: 6, left: 52),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFF232C63),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, kNavigationLogin),
                        child: Text(
                          'Login',
                          style: TextStyle(
                              color: Color(0xFF232C63),
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                              height: 1),
                        ))),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        color: Color(0xFF232C63),
                        border: Border.all(
                          color: Color(0xFF232C63),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Register',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                              height: 1),
                        )))
              ],
            ),
          ),
          ListTile(
            leading: SvgPicture.asset('assets/images/sidebar/referNearn.svg'),
            title: Text('Refer & Earn',
                style: TextStyle(
                    color: Color(0xFF232C63),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 1)),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
                'assets/images/sidebar/registerAsPetPartner.svg'),
            title: Text('Register as Pet Partner',
                style: TextStyle(
                    color: Color(0xFF232C63),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 1)),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: SvgPicture.asset('assets/images/sidebar/support.svg'),
            title: Text('Support',
                style: TextStyle(
                    color: Color(0xFF232C63),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 1)),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: SvgPicture.asset('assets/images/sidebar/shop.svg'),
            title: Text('Shop',
                style: TextStyle(
                    color: Color(0xFF232C63),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 1)),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading:
                SvgPicture.asset('assets/images/sidebar/privacyPolicy.svg'),
            title: Text('Privacy & Policy',
                style: TextStyle(
                    color: Color(0xFF232C63),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 1)),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
                'assets/images/sidebar/registerAsPetPartner.svg'),
            title: Text('Register as Pet Partner',
                style: TextStyle(
                    color: Color(0xFF232C63),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 1)),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          Expanded(
              child: Align(
            alignment: Alignment.bottomLeft,
            child: ListTile(
              leading: SvgPicture.asset('assets/images/sidebar/login.svg'),
              title: Text('Login',
                  style: TextStyle(
                      color: Color(0xFF232C63),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1)),
              onTap: () {
                Navigator.pushNamed(context, kNavigationLogin);
              },
            ),
          ))
        ],
      ),
    );
  }
}
