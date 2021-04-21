import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:the_pet_nest/konstants/styles.dart';

class PetParentReviewCard extends StatelessWidget {
  final String name;
  final String date;
  final double rating;
  final String userImage;
  final List<String> petImage;
  final String review;

  const PetParentReviewCard(
      {this.name,
      this.date,
      this.rating,
      this.userImage,
      this.petImage,
      this.review});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8.05),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [kContainerBoxShadow],
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.asset(
                      'assets/placeholder.png',
                      height: 60,
                      width: 60,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                    ),
                    Text(
                      date,
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 10),
                    ),
                    RatingBarIndicator(
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 8.0,
                      ),
                      itemSize: 18,
                      itemCount: 5,
                      rating: rating,
                    ),
                  ],
                )
              ],
            ),
            Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: petImage.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Image.asset('assets/placeholder.png');
                },
              ),
            ),
            Container(
              width: 250,
              child: Text(
                review,
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
