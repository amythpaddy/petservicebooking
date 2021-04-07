import 'package:flutter/material.dart';

class ServicesCard extends StatelessWidget {
  final String text;
  final IconData icon;

  const ServicesCard({this.text, this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      // width: 140,
      // height: 122,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color.fromARGB(50, 255, 119, 23),
              ),
              child: Icon(
                icon,
                color: Color(0xFFFF771F),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Text(
                text,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}
