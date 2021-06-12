import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:the_pet_nest/config/sizeConfig.dart';
import 'package:the_pet_nest/konstants/styles.dart';

class PetParentReviewCard extends StatelessWidget {
  final String name;
  final String date;
  final double rating;
  final String userImage;
  final String review;

  const PetParentReviewCard(
      {required this.name,
      required this.date,
      required this.rating,
      required this.userImage,
      required this.review});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      margin: EdgeInsets.only(right: 8.05),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: SizeConfig.blockSizeHorizontal! * 90,
      constraints: BoxConstraints(maxHeight: 101),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [kContainerBoxShadow],
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                name,
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 12, height: 1.5),
              ),
              Text(
                date,
                style: TextStyle(
                    fontWeight: FontWeight.w300, fontSize: 10, height: 1.5),
              ),
            ],
          ),
          RatingBarIndicator(
            itemBuilder: (context, index) => Icon(
              Icons.star,
              color: Colors.amber,
              size: 8.0,
            ),
            itemSize: 8,
            itemCount: 5,
            rating: rating,
          ),
          Container(
            margin: EdgeInsets.only(right: 9),
            child: Text(
              review,
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
            ),
          )
        ],
      ),
    );
  }
}
