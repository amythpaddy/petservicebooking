import 'package:flutter/material.dart';
import 'package:the_pet_nest/config/sizeConfig.dart';
import 'package:the_pet_nest/konstants/colors.dart';

class TimeSelectionCard extends StatelessWidget {
  const TimeSelectionCard(
      {Key? key,
      required this.selected,
      required this.available,
      required this.displayText,
      required this.onPressed})
      : super(key: key);
  final bool selected;
  final bool available;
  final String displayText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
        onPressed: () {
          if (available) onPressed();
        },
        child: Container(
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
              color: selected ? kAppIconColor : Colors.white,
              border: Border.all(
                  color: selected ? kAppIconColor : Color(0xFFDEDFDF)),
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              Text(displayText,
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      height: 1.5,
                      color: selected ? Colors.white : Color(0xFF1A202E))),
              Text(
                available ? 'Available' : 'Booked',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    height: 1.5,
                    color: available
                        ? selected
                            ? Colors.white
                            : kAppIconColor
                        : Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }
}
