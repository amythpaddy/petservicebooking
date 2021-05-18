import 'package:flutter/material.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/styles.dart';
import 'package:the_pet_nest/konstants/values.dart';
import 'package:the_pet_nest/profiles/petProfile/component/checkboxWithText.dart';
import 'package:the_pet_nest/profiles/petProfile/component/heading.dart';
import 'package:the_pet_nest/profiles/petProfile/component/optionsChip.dart';
import 'package:the_pet_nest/profiles/userProfile/component/userDetailInput.dart';

class AddPetProfile extends StatefulWidget {
  const AddPetProfile({Key key}) : super(key: key);

  @override
  _AddPetProfileState createState() => _AddPetProfileState();
}

class _AddPetProfileState extends State<AddPetProfile> {
  String gender = kPetGenderNone;
  String aggression = kPetAggressionMedium;
  bool vaccinated = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add Profile',
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
                height: 40,
              ),
              Container(
                  width: double.infinity,
                  decoration: kActiveButtonContainerStyle,
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Submit',
                        style: kActiveButtonTextStyle,
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
