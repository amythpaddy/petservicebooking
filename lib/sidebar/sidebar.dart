import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_pet_nest/konstants.dart';

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
                        onPressed: () {},
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
            leading: Icon(
              Icons.person_add_alt_1_outlined,
              color: kAppIconColor,
            ),
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
            leading: Icon(
              Icons.app_registration,
              color: kAppIconColor,
            ),
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
            leading: Icon(
              Icons.star_border,
              color: kAppIconColor,
            ),
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
            leading: Icon(
              Icons.shopping_cart_outlined,
              color: kAppIconColor,
            ),
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
            leading: Icon(
              Icons.list_alt_rounded,
              color: kAppIconColor,
            ),
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
            leading: Icon(
              Icons.shield,
              color: kAppIconColor,
            ),
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
              leading: Icon(
                Icons.login_rounded,
                color: kAppIconColor,
              ),
              title: Text('Login',
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
          ))
        ],
      ),
    );
  }
}
