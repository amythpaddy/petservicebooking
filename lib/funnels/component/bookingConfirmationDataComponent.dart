import 'package:flutter/material.dart';

class BookingConfirmationDataComponent extends StatelessWidget {
  const BookingConfirmationDataComponent({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style:
              TextStyle(fontWeight: FontWeight.w400, fontSize: 14, height: 1.5),
        ),
        Text(value,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 1.5,
              color: Color(0x771A202E),
            ))
      ],
    );
  }
}
