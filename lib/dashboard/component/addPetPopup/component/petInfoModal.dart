import 'package:flutter/material.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/styles.dart';
import 'package:the_pet_nest/konstants/values.dart';
import 'package:the_pet_nest/profiles/petProfile/component/checkboxWithText.dart';
import 'package:the_pet_nest/profiles/petProfile/component/heading.dart';
import 'package:the_pet_nest/profiles/petProfile/component/optionsChip.dart';
import 'package:the_pet_nest/profiles/userProfile/component/userDetailInput.dart';

class PetInfoModal extends StatefulWidget {
  const PetInfoModal({Key? key, required this.petInfoScreenResponse})
      : super(key: key);
  final Function petInfoScreenResponse;

  @override
  _PetInfoModalState createState() =>
      _PetInfoModalState(petInfoScreenResponse: petInfoScreenResponse);
}

class _PetInfoModalState extends State<PetInfoModal> {
  String gender = kPetGenderNone;
  String aggression = kPetAggressionMedium;
  bool vaccinated = false;
  final Function petInfoScreenResponse;

  _PetInfoModalState({required this.petInfoScreenResponse});
  @override
  Widget build(BuildContext context) {
    return Container(
      // constraints: BoxConstraints.expand(),
      margin: EdgeInsets.symmetric(horizontal: 20.5),
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
            height: 14,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 92,
                      width: 92,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Color(0x77000000)),
                      ),
                    ),
                    Icon(
                      Icons.camera_alt_outlined,
                      color: kAppIconColor,
                      size: 30,
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 13,
              ),
              Flexible(
                  child: UserDetailInput(
                heading: 'Pet`s Name',
                required: true,
                onDataFilled: (String value) {},
                value: 'Test Value',
              )),
            ],
          ),
          SizedBox(
            height: 18,
          ),
          Heading(
            heading: 'Gender',
            required: true,
          ),
          SizedBox(
            height: 4,
          ),
          Row(
            children: [
              OptionsChip(
                title: 'Male',
                selected: gender == kPetGenderMale,
                onSelected: () {
                  setState(() {
                    gender = kPetGenderMale;
                  });
                },
              ),
              OptionsChip(
                title: 'Female',
                selected: gender == kPetGenderFemale,
                onSelected: () {
                  setState(() {
                    gender = kPetGenderFemale;
                  });
                },
              ),
              OptionsChip(
                title: 'None',
                selected: gender == kPetGenderNone,
                onSelected: () {
                  setState(() {
                    gender = kPetGenderNone;
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          UserDetailInput(
            heading: 'Breed',
            required: true,
            onDataFilled: (data) {},
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Expanded(
                  child: UserDetailInput(
                heading: 'Age',
                required: true,
                onDataFilled: (data) {},
              )),
              SizedBox(
                width: 7,
              ),
              Expanded(
                  child: UserDetailInput(
                heading: 'Weight',
                required: true,
                onDataFilled: (data) {},
              ))
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Heading(
            heading: 'Aggression',
            required: true,
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              OptionsChip(
                title: 'Low',
                selected: aggression == kPetAggressionLow,
                onSelected: () {
                  setState(() {
                    aggression = kPetAggressionLow;
                  });
                },
              ),
              OptionsChip(
                title: 'Medium',
                selected: aggression == kPetAggressionMedium,
                onSelected: () {
                  setState(() {
                    aggression = kPetAggressionMedium;
                  });
                },
              ),
              OptionsChip(
                title: 'High',
                selected: aggression == kPetAggressionHigh,
                onSelected: () {
                  setState(() {
                    aggression = kPetAggressionHigh;
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 19,
          ),
          Heading(
            heading: 'Vaccinated',
            required: true,
          ),
          Row(
            children: [
              CheckboxWithText(
                  title: 'Yes',
                  selected: vaccinated,
                  onChanged: () {
                    setState(() {
                      vaccinated = true;
                    });
                  }),
              SizedBox(
                width: 45,
              ),
              CheckboxWithText(
                  title: 'No',
                  selected: !vaccinated,
                  onChanged: () {
                    setState(() {
                      vaccinated = false;
                    });
                  })
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Container(
              width: double.infinity,
              decoration: kActiveButtonContainerStyle,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: TextButton(
                  onPressed: () {
                    petInfoScreenResponse(kPopupAddedPetList);
                  },
                  child: Text(
                    'Next',
                    style: kActiveButtonTextStyle,
                  )))
        ],
      ),
    );
  }
}
