import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/values.dart';

class SelectAddedPetCard extends StatelessWidget {
  const SelectAddedPetCard(
      {Key? key,
      required this.image,
      required this.name,
      required this.breed,
      required this.petCategory,
      this.selected = false})
      : super(key: key);
  final String image;
  final String name;
  final String breed;
  final String petCategory;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 82,
              width: 82,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                    color: selected ? kAppIconColor : Color(0x331A202E),
                    width: 1),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  image.isEmpty
                      ? SvgPicture.asset(
                          petCategory == kPetCategoryDog
                              ? 'assets/images/dog_avatar.svg'
                              : 'assets/images/cat_avatar.svg',
                          height: 60,
                          width: 60,
                        )
                      : Image.asset(
                          image,
                          fit: BoxFit.fill,
                          height: 82,
                          width: 82,
                        ),
                  Visibility(
                    visible: selected,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        height: 82,
                        width: 82,
                        color: Color(0x4E000000),
                        child: Icon(
                          Icons.check_circle,
                          color: kAppIconColor,
                        ),
                      ),
                    ),
                  ),
                ],
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
                  color: Color(0xFFAFB0B5)),
            )
          ]),
    );
  }
}
