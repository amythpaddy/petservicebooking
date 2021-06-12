import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_pet_nest/konstants/styles.dart';

class AddLocationComponent extends StatelessWidget {
  const AddLocationComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        padding: EdgeInsets.symmetric(vertical: 11.58, horizontal: 14.17),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [kContainerBoxShadow]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/funnels/icon_add_home.svg',
              height: 26,
              width: 26,
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              'Add Address',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
          ],
        ));
  }
}
