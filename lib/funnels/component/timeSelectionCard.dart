import 'package:flutter/material.dart';
import 'package:the_pet_nest/konstants/colors.dart';

class TimeSelectionCard extends StatelessWidget {
  const TimeSelectionCard(
      {Key? key, required this.selected, required this.available})
      : super(key: key);
  final bool selected;
  final bool available;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: available ? kAppIconColor : Colors.grey),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Text('9:00-10:00',
              style: TextStyle(
                  fontWeight: FontWeight.w300, fontSize: 14, height: 1.5)),
          Text(
            available ? 'Available' : 'Booked',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 10,
                height: 1.5,
                color: kAppIconColor),
          )
        ],
      ),
    );
  }
}
