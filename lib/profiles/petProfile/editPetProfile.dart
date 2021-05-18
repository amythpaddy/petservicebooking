import 'package:flutter/material.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/styles.dart';
import 'package:the_pet_nest/konstants/values.dart';
import 'package:the_pet_nest/profiles/petProfile/component/checkboxWithText.dart';
import 'package:the_pet_nest/profiles/petProfile/component/heading.dart';
import 'package:the_pet_nest/profiles/petProfile/component/optionsChip.dart';
import 'package:the_pet_nest/profiles/userProfile/component/userDetailInput.dart';

class EditPetProfile extends StatefulWidget {
  const EditPetProfile({Key key}) : super(key: key);

  @override
  _EditPetProfileState createState() => _EditPetProfileState();
}

class _EditPetProfileState extends State<EditPetProfile> {
  String gender = kPetGenderNone;
  String aggression = kPetAggressionMedium;
  bool vaccinated = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: kAppBarTitleStyle,
        ),
        backgroundColor: kAppBackgroundColor,
        elevation: 0,
      ),
      body: Container(
        color: kAppBackgroundColor,
        margin: EdgeInsets.all(23),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'assets/images/profile/dog_avatar.png',
                          width: 92,
                          height: 92,
                        ),
                        Container(
                          height: 92,
                          width: 92,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color(0x77000000)),
                        ),
                        Icon(
                          Icons.camera_alt_outlined,
                          color: Color(0x77FFFFFF),
                          size: 20,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 13,
                  ),
                  Flexible(
                      child: UserDetailInput(
                    heading: 'Name',
                    required: true,
                    onDataFilled: (String value) {},
                    value: 'Test Value',
                  )),
                ],
              ),
              SizedBox(
                height: 20.5,
              ),
              Heading(
                heading: 'Gender',
                required: true,
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
                height: 19,
              ),
              UserDetailInput(
                heading: 'Breed',
                required: true,
                onDataFilled: (data) {},
              ),
              SizedBox(
                height: 19,
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
                height: 19,
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
                height: 70,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: kActiveButtonOutlineContainerStyle,
                      child: TextButton(
                        child: Text(
                          'Cancel',
                          style: kActiveButtonOutlineTextStyle,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Container(
                      decoration: kActiveButtonContainerStyle,
                      child: TextButton(
                        child: Text(
                          'Submit',
                          style: kActiveButtonTextStyle,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}