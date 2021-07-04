import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/enums.dart';
import 'package:the_pet_nest/konstants/styles.dart';
import 'package:the_pet_nest/profiles/bloc/petProfile/petProfileBloc.dart';
import 'package:the_pet_nest/profiles/bloc/petProfile/petProfileState.dart';
import 'package:the_pet_nest/profiles/model/petBreedModel.dart';
import 'package:the_pet_nest/profiles/petProfile/component/checkboxWithText.dart';
import 'package:the_pet_nest/profiles/petProfile/component/heading.dart';
import 'package:the_pet_nest/profiles/petProfile/component/optionsChip.dart';
import 'package:the_pet_nest/profiles/userProfile/component/userDetailInput.dart';

class PetInfoModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // constraints: BoxConstraints.expand(),
      margin: EdgeInsets.symmetric(horizontal: 20.5),
      color: Colors.transparent,
      child: BlocBuilder<PetProfileBloc, PetProfileState>(
        builder: (blocContext, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 12.76,
              ),
              Container(
                height: 2,
                width: 38.34,
                decoration: BoxDecoration(
                    color: kAppIconColor,
                    borderRadius: BorderRadius.circular(1)),
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
                    onDataFilled: (value) =>
                        BlocProvider.of<PetProfileBloc>(blocContext)
                            .petNameChanged(value),
                    value: state.addUpdatePet!.name,
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
                    selected: state.addUpdatePet!.gender == Gender.MALE,
                    onSelected: () =>
                        BlocProvider.of<PetProfileBloc>(blocContext)
                            .petGenderChanged(Gender.MALE),
                  ),
                  OptionsChip(
                    title: 'Female',
                    selected: state.addUpdatePet!.gender == Gender.FEMALE,
                    onSelected: () =>
                        BlocProvider.of<PetProfileBloc>(blocContext)
                            .petGenderChanged(Gender.FEMALE),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Heading(
                heading: 'Breed',
                required: true,
              ),
              DropdownSearch<BreedDetail>(
                mode: Mode.DIALOG,
                showSelectedItem: true,
                items: state.petBreeds!.listOfDogBreed,
                itemAsString: (breed) => breed.name,
                hint: "Choose Pet's Breed",
                onChanged: (value) => BlocProvider.of<PetProfileBloc>(context)
                    .petBreedChanged(value!),
                compareFn: (i, s) {
                  return true;
                },
                showSearchBox: true,
                showClearButton: true,
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
                          onDataFilled: (value) =>
                              BlocProvider.of<PetProfileBloc>(blocContext)
                                  .petAgeChanged(value),
                          inputType: TextInputType.number,
                          value: state.addUpdatePet!.age.toString())),
                  SizedBox(
                    width: 7,
                  ),
                  Expanded(
                      child: UserDetailInput(
                    heading: 'Weight',
                    required: true,
                    onDataFilled: (value) =>
                        BlocProvider.of<PetProfileBloc>(blocContext)
                            .petWeightChanged(value),
                    inputType: TextInputType.number,
                    value: state.addUpdatePet!.weight.toString(),
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
                    selected: state.addUpdatePet!.aggression == Aggression.LOW,
                    onSelected: () {
                      BlocProvider.of<PetProfileBloc>(context)
                          .petAggressionChanged(Aggression.LOW);
                    },
                  ),
                  OptionsChip(
                    title: 'Medium',
                    selected:
                        state.addUpdatePet!.aggression == Aggression.MEDIUM,
                    onSelected: () {
                      BlocProvider.of<PetProfileBloc>(context)
                          .petAggressionChanged(Aggression.MEDIUM);
                    },
                  ),
                  OptionsChip(
                    title: 'High',
                    selected: state.addUpdatePet!.aggression == Aggression.HIGH,
                    onSelected: () {
                      BlocProvider.of<PetProfileBloc>(context)
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
                        BlocProvider.of<PetProfileBloc>(context)
                            .petVaccinationCountChanged(1);
                      }),
                  SizedBox(
                    width: 45,
                  ),
                  CheckboxWithText(
                      title: 'No',
                      selected: state.addUpdatePet!.vaccine == 0,
                      onChanged: () {
                        BlocProvider.of<PetProfileBloc>(context)
                            .petVaccinationCountChanged(0);
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
                        if (!state.addingPet)
                          BlocProvider.of<PetProfileBloc>(context)
                              .createNewPet();
                      },
                      child: state.addingPet
                          ? CircularProgressIndicator()
                          : Text(
                              'Next',
                              style: kActiveButtonTextStyle,
                            )))
            ],
          );
        },
      ),
    );
  }
}
