import 'package:flutter/material.dart';
import 'package:the_pet_nest/konstants/colors.dart';

class SelectAddedPetCard extends StatelessWidget {
  const SelectAddedPetCard(
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
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
                color: selected ? kAppIconColor : Color(0x331A202E), width: 1),
          ),
          padding: EdgeInsets.all(5),
          child: Image.asset(
            image.isEmpty ? 'assets/images/profile/dog_avatar.png' : image,
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
          style: TextStyle(
              fontSize: 16,
              height: 1.5,
              fontWeight: FontWeight.w600,
              color: Colors.black87),
        ),
        Text(
          breed,
          style: TextStyle(
              fontSize: 12,
              height: 1.5,
              fontWeight: FontWeight.w400,
              color: Colors.black87),
        )
      ]),
    );
  }
}
