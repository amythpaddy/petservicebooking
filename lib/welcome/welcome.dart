import 'package:flutter/material.dart';
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
          children: [
            Positioned(
              top: 150,
              left: 100,
              width: 300,
              child: Image.asset('assets/the_pet_nest.png'),
            ),
            Positioned(
                bottom: 50,
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Login',
                          style: TextStyle(color: kAppIconColor),
                        ))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
