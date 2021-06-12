import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/styles.dart';
import 'package:the_pet_nest/profiles/petProfile/component/checkboxWithText.dart';

class PetSelectModal extends StatefulWidget {
  final Function selectPetScreenResponse;
  const PetSelectModal({Key? key, required this.selectPetScreenResponse})
      : super(key: key);

  @override
  _PetSelectModalState createState() =>
      _PetSelectModalState(selectPetScreenResponse);
}

class _PetSelectModalState extends State<PetSelectModal> {
  final Function selectPetScreenResponse;
  bool _dogSelected = false;

  _PetSelectModalState(this.selectPetScreenResponse);
  @override
  Widget build(BuildContext context) {
    return Container(
        // constraints: BoxConstraints.expand(),
        margin: EdgeInsets.symmetric(horizontal: 20.5),
        color: Colors.transparent,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: 12.76,
          ),
          Container(
            height: 2,
            width: 38.34,
            decoration: BoxDecoration(
                color: kAppIconColor, borderRadius: BorderRadius.circular(1)),
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            'Select Your Pet',
            style: TextStyle(
                height: 1.5,
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: kTextColorBlue),
          ),
          SizedBox(
            height: 55,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SvgPicture.asset('assets/images/login/dog_image.svg'),
                  CheckboxWithText(
                    title: 'Dog',
                    selected: _dogSelected,
                    onChanged: () {
                      setState(() {
                        _dogSelected = true;
                      });
                    },
                  )
                ],
              ),
              SizedBox(
                width: 75,
              ),
              Column(
                children: [
                  SvgPicture.asset('assets/images/login/cat_image.svg'),
                  CheckboxWithText(
                    title: 'Cat',
                    selected: !_dogSelected,
                    onChanged: () {
                      setState(() {
                        _dogSelected = false;
                      });
                    },
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 51.27,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: kActiveButtonContainerStyle,
            child: TextButton(
              onPressed: () {
                selectPetScreenResponse("");
              },
              child: Text(
                'Next',
                textAlign: TextAlign.center,
                style: kActiveButtonTextStyle,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            decoration: kActiveButtonOutlineContainerStyle,
            child: Text(
              'Cancel',
              textAlign: TextAlign.center,
              style: kActiveButtonOutlineTextStyle,
            ),
          )
        ]));
  }
}
