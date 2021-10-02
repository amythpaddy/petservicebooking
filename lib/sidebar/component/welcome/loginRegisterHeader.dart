import 'package:flutter/material.dart';
import 'package:the_pet_nest/konstants/paths.dart';
import 'package:the_pet_nest/sidebar/component/welcome/welcomeModal.dart';

class LoginRegisterHeader extends StatelessWidget {
  final Function dismissDrawer;

  const LoginRegisterHeader({Key? key, required this.dismissDrawer})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            constraints: BoxConstraints(
              minWidth: 72,
              maxHeight: 32,
            ),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFF232C63),
                ),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: TextButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero)),
                onPressed: () {
                  dismissDrawer(context);
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
                },
                // Navigator.pushNamed(context, kNavigationLogin),
                child: Text(
                  'Login',
                  style: TextStyle(
                      color: Color(0xFF232C63),
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                      height: 1.5),
                ))),
        SizedBox(
          width: 6,
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 14),
            constraints: BoxConstraints(maxHeight: 32, minWidth: 76),
            decoration: BoxDecoration(
                color: Color(0xFF232C63),
                border: Border.all(
                  color: Color(0xFF232C63),
                ),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, kNavigationRegister);
                },
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero)),
                child: Text(
                  'Register',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                      height: 1.5),
                )))
      ],
    );
  }
}
