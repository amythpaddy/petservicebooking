import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PetHeroesCard extends StatelessWidget {
  final String name;
  final String service;
  final int appointmentCompleted;
  final double rating;
  // final ImageData image;

  const PetHeroesCard(
      {this.name, this.service, this.appointmentCompleted, this.rating});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 56,
              height: 78,
              child: Icon(
                Icons.person_outline,
              ),
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
                            fontWeight: FontWeight.w400, fontSize: 12)),
                    Text(
                      appointmentCompleted.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                    )
                  ],
                )
              ],
            ),
            Container(
              height: 56,
              width: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Color.fromARGB(50, 255, 119, 23),
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