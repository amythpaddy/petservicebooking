import 'package:flutter/material.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/styles.dart';
import 'package:the_pet_nest/profiles/userProfile/component/userDetailInput.dart';

class EditUserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Edit Profile', style: kAppBarTitleStyle),
        backgroundColor: kAppBackgroundColor,
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 40, horizontal: 22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/avatar.png',
                        width: 82,
                        height: 82,
                      ),
                      Container(
                        height: 82,
                        width: 82,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color(0x77000000)),
                      ),
                      Icon(
                        Icons.camera_alt_outlined,
                        color: Color(0x77FFFFFF),
                        size: 20,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 13,
                ),
                Flexible(
                    child: UserDetailInput(
                  heading: 'Name',
                  required: true,
                  onDataFilled: (String value) {},
                  value: 'Test Value',
                )),
              ],
            ),
            SizedBox(
              height: 20.5,
            ),
            UserDetailInput(
                heading: 'Email',
                required: true,
                onDataFilled: (String value) {},
                value: 'test@email.com'),
            SizedBox(
              height: 20.5,
            ),
            UserDetailInput(
                heading: 'Phone number',
                required: true,
                onDataFilled: (String value) {},
                value: '+91 987654321'),
            SizedBox(
              height: 150,
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: kActiveButtonOutlineContainerStyle,
                      child: Text(
                        'Cancel',
                        style: kActiveButtonOutlineTextStyle,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: kActiveButtonContainerStyle,
                    child: Text(
                      'Submit',
                      style: kActiveButtonTextStyle,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
