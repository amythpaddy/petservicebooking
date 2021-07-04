import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/enums.dart';
import 'package:the_pet_nest/konstants/styles.dart';
import 'package:the_pet_nest/profiles/bloc/petProfile/petProfileBloc.dart';
import 'package:the_pet_nest/profiles/bloc/petProfile/petProfileState.dart';
import 'package:the_pet_nest/profiles/model/petBreedModel.dart';
import 'package:the_pet_nest/profiles/userProfile/component/userDetailInput.dart';
import 'package:the_pet_nest/utils/utils.dart';

import 'component/checkboxWithText.dart';
import 'component/heading.dart';
import 'component/optionsChip.dart';

class EditPetProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PetProfileBloc _petProfileBloc =
        ModalRoute.of(context)!.settings.arguments as PetProfileBloc;
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
      backgroundColor: kAppBackgroundColor,
      body: Container(
        margin: EdgeInsets.all(23),
        child: SingleChildScrollView(
            child: BlocProvider(
          create: (_) => _petProfileBloc,
          child: BlocListener<PetProfileBloc, PetProfileState>(
            listener: (context, state) {
              if (state.updatingPet) {
                Navigator.pop(context);
              } else if (state.error) {
                showSnackbar(context: context);
              }
            },
            child: BlocBuilder<PetProfileBloc, PetProfileState>(
              builder: (blocContext, state) {
                return Column(
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
                          onDataFilled: (String value) {
                            _petProfileBloc.petNameChanged(value);
                          },
                          value: state.addUpdatePet!.name,
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
                          selected: state.addUpdatePet!.gender == Gender.MALE,
                          onSelected: () {
                            _petProfileBloc.petGenderChanged(Gender.MALE);
                          },
                        ),
                        OptionsChip(
                          title: 'Female',
                          selected: state.addUpdatePet!.gender == Gender.FEMALE,
                          onSelected: () {
                            _petProfileBloc.petGenderChanged(Gender.FEMALE);
                          },
                        ),
                        // OptionsChip(
                        //   title: 'None',
                        //   selected: gender == kPetGenderNone,
                        //   onSelected: () {
                        //     setState(() {
                        //       gender = kPetGenderNone;
                        //     });
                        //   },
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: 19,
                    ),
                    Heading(
                      heading: 'Breed',
                      required: true,
                    ),
                    DropdownSearch<BreedDetail>(
                      mode: Mode.BOTTOM_SHEET,
                      showSelectedItem: true,
                      items: state.petBreeds!.listOfDogBreed,
                      itemAsString: (breed) => breed.name,
                      selectedItem: state.addUpdatePet!.subCategory,
                      hint: "Choose Pet's Breed",
                      onChanged: (value) =>
                          _petProfileBloc.petBreedChanged(value!),
                      compareFn: (i, s) {
                        return true;
                      },
                      showSearchBox: true,
                      showClearButton: true,
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
                          inputType: TextInputType.number,
                          value: state.addUpdatePet!.age.toString(),
                          onDataFilled: (data) =>
                              _petProfileBloc.petAgeChanged(data),
                        )),
                        SizedBox(
                          width: 7,
                        ),
                        Expanded(
                            child: UserDetailInput(
                                heading: 'Weight',
                                required: true,
                                inputType: TextInputType.number,
                                value: state.addUpdatePet!.weight.toString(),
                                onDataFilled: (data) =>
                                    _petProfileBloc.petWeightChanged(data)))
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
                          selected:
                              state.addUpdatePet!.aggression == Aggression.LOW,
                          onSelected: () {
                            _petProfileBloc
                                .petAggressionChanged(Aggression.LOW);
                          },
                        ),
                        OptionsChip(
                          title: 'Medium',
                          selected: state.addUpdatePet!.aggression ==
                              Aggression.MEDIUM,
                          onSelected: () {
                            _petProfileBloc
                                .petAggressionChanged(Aggression.MEDIUM);
                          },
                        ),
                        OptionsChip(
                          title: 'High',
                          selected:
                              state.addUpdatePet!.aggression == Aggression.HIGH,
                          onSelected: () {
                            _petProfileBloc
                                .petAggressionChanged(Aggression.HIGH);
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
                            selected: state.addUpdatePet!.vaccine == 1,
                            onChanged: () {
                              _petProfileBloc.petVaccinationCountChanged(1);
                            }),
                        SizedBox(
                          width: 45,
                        ),
                        CheckboxWithText(
                            title: 'No',
                            selected: state.addUpdatePet!.vaccine == 0,
                            onChanged: () {
                              _petProfileBloc.petVaccinationCountChanged(0);
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
                              onPressed: () {
                                _petProfileBloc.updatePetData();
                              },
                              child: state.updatingPet
                                  ? CircularProgressIndicator()
                                  : Text(
                                      'Submit',
                                      style: kActiveButtonTextStyle,
                                    ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        )),
      ),
    );
  }
}
