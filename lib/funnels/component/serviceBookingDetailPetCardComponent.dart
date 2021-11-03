import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/styles.dart';
import 'package:the_pet_nest/konstants/values.dart';

class ServiceBookingDetailPetCardComponent extends StatelessWidget {
  const ServiceBookingDetailPetCardComponent(
      {Key? key,
      required this.petName,
      required this.bookingDate,
      required this.servicePrice,
      required this.bookingService,
      required this.petCategory})
      : super(key: key);
  final String petName;
  final String bookingDate;
  final String servicePrice;
  final String bookingService;
  final String petCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12.5),
        margin: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [kContainerBoxShadow]),
        child: Row(
          children: [
            SvgPicture.asset(
              petCategory == kPetCategoryDog
                  ? 'assets/images/dog_avatar.svg'
                  : 'assets/images/cat_avatar.svg',
              height: 46,
              width: 46,
            ),
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
                        fontWeight: FontWeight.w700,
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
