import 'package:flutter/material.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/styles.dart';

class ServiceBookingDetailPetCardComponent extends StatelessWidget {
  const ServiceBookingDetailPetCardComponent(
      {Key? key,
      required this.petName,
      required this.bookingDate,
      required this.servicePrice,
      required this.bookingService})
      : super(key: key);
  final String petName;
  final String bookingDate;
  final String servicePrice;
  final String bookingService;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14.5),
        margin: EdgeInsets.symmetric(vertical: 8.2),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [kContainerBoxShadow]),
        child: Row(
          children: [
            Image.asset('assets/images/profile/dog_avatar.png'),
            SizedBox(
              width: 8.84,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  petName,
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 16, height: 1.5),
                ),
                Visibility(
                  visible: false,
                  child: Text(
                    bookingDate,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        height: 1.5,
                        color: Colors.grey),
                  ),
                ),
              ],
            )),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    bookingService,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  Text(
                    '\u{20B9} $servicePrice',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        height: 1.5,
                        color: kAppIconColor),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
