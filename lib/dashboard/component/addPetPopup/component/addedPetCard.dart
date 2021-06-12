import 'package:flutter/material.dart';
import 'package:the_pet_nest/konstants/colors.dart';

class AddedPetCard extends StatelessWidget {
  const AddedPetCard(
      {Key? key,
      required this.image,
      required this.name,
      required this.breed,
      this.selected = false})
      : super(key: key);
  final String image;
  final String name;
  final String breed;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 33),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(41),
            border: Border.all(color: kAppIconColor, width: 2),
          ),
          child: Image.asset(
            image,
            fit: BoxFit.fill,
            height: 82,
            width: 82,
          ),
        ),
        SizedBox(
          height: 7.37,
        ),
        Text(
          name,
          style:
              TextStyle(fontSize: 20, height: 1.5, fontWeight: FontWeight.w600),
        ),
        Text(
          breed,
          style:
              TextStyle(fontSize: 14, height: 1.5, fontWeight: FontWeight.w400),
        )
      ]),
    );
  }
}
