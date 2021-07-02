import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_pet_nest/konstants/dataAccessors.dart';
import 'package:the_pet_nest/konstants/paths.dart';
import 'package:the_pet_nest/sidebar/component/welcome/loginRegisterHeader.dart';
import 'package:the_pet_nest/sidebar/component/welcome/userHeaderTile.dart';

class Sidebar extends StatefulWidget {
  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  bool loggedIn = false;

  late SharedPreferences pref;

  void dismissDrawer(context) {
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    getLoggedInState();
  }

  void getLoggedInState() async {
    pref = await SharedPreferences.getInstance();
    String token = pref.getString(kDataToken) ?? '';
    if (token.isNotEmpty)
      setState(() {
        loggedIn = true;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF9F9F9)),
            child: loggedIn
                ? LoggedInHeader()
                : LoginRegisterHeader(
                    dismissDrawer: dismissDrawer,
                  ),
          ),
          ListTile(
            leading: SvgPicture.asset('assets/images/sidebar/referNearn.svg'),
            title: Text('Refer & Earn',
                style: TextStyle(
                    color: Color(0xFF232C63),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 1.5)),
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
                    height: 1.5)),
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
                    height: 1.5)),
            onTap: () {
              Navigator.pushNamed(context, kNavigationSupport);
            },
          ),
          ListTile(
            leading: SvgPicture.asset('assets/images/sidebar/shop.svg'),
            title: Text('Shop',
                style: TextStyle(
                    color: Color(0xFF232C63),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 1.5)),
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
                    height: 1.5)),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: SvgPicture.asset('assets/images/sidebar/tnc.svg'),
            title: Text('Terms & Condition',
                style: TextStyle(
                    color: Color(0xFF232C63),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 1.5)),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          Expanded(
              child: Align(
            alignment: Alignment.bottomLeft,
            child: ListTile(
              leading: loggedIn
                  ? SvgPicture.asset('assets/images/sidebar/logout.svg')
                  : SvgPicture.asset('assets/images/sidebar/login.svg'),
              title: Text(loggedIn ? 'Logout' : 'Login',
                  style: TextStyle(
                      color: Color(0xFF232C63),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.5)),
              onTap: () {
                if (loggedIn) {
                  pref.clear();
                  Navigator.pushReplacementNamed(context, kNavigationWelcome);
                } else
                  Navigator.pushNamed(context, kNavigationLogin);
              },
            ),
          ))
        ],
      ),
    );
  }
}
