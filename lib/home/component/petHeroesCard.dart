import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/styles.dart';

class PetHeroesCard extends StatelessWidget {
  final String name;
  final String service;
  final int appointmentCompleted;
  final double rating;
  // final ImageData image;

  const PetHeroesCard(
      {required this.name,
      required this.service,
      required this.appointmentCompleted,
      required this.rating});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 9),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [kContainerBoxShadow],
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 56,
              height: 78,
              child: SvgPicture.asset(
                  'assets/images/home/pet_hero_placeholder.svg'),
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
                Text(
                  service,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                ),
                Row(
                  children: [
                    RatingBarIndicator(
                      itemBuilder: (context, index) =>
                          Icon(Icons.star, color: Colors.amber),
                      itemCount: 5,
                      rating: rating,
                      itemSize: 18,
                    ),
                    Text(
                      rating.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text('Appointment Completed - ',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color(0xFF666666))),
                    Text(
                      appointmentCompleted.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: kTextColorBlue),
                    )
                  ],
                )
              ],
            ),
            Container(
              height: 60,
              width: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Color.fromARGB(15, 255, 119, 23),
              ),
              child: Icon(
                Icons.navigate_next,
                color: Color(0xFFFF7717),
              ),
            )
          ],
        ),
      ),
    );
  }
}
