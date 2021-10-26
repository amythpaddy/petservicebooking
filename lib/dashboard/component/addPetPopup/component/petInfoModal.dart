import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
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
      child: Column(
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
            height: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: BlocBuilder<PetProfileBloc, PetProfileState>(
                builder: (blocContext, state) {
                  if (state.petBreeds == null) {
                    BlocProvider.of<PetProfileBloc>(blocContext).getPetBreed();
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.all(0)),
                              onPressed: () =>
                                  BlocProvider.of<PetProfileBloc>(context)
                                      .selectPetImage("1"),
                              child: Container(
                                height: 82,
                                width: 82,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: Color(0x77000000)),
                                ),
                                child: state.image == null
                                    ? Icon(
                                        Icons.camera_alt_outlined,
                                        color: kAppIconColor,
                                        size: 30,
                                      )
                                    : kIsWeb
                                        ? Image.network(state.image!.path)
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(82),
                                            child: Image.file(
                                              File(state.image!.path),
                                              height: 82,
                                              width: 82,
                                            ),
                                          ),
                              )),
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
                            showError: state.errorNameIsMissing,
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
                            selected:
                                state.addUpdatePet!.gender == Gender.FEMALE,
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
                        heading: 'Category',
                        required: true,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      state.petBreeds == null
                          ? Center(
                              child: CircularProgressIndicator(
                                color: kAppIconColor,
                              ),
                            )
                          : Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                      width: 1,
                                      color: state.errorBreedIsMissing
                                          ? Colors.redAccent
                                          : Colors.transparent)),
                              child: DropdownSearch<BreedDetail>(
                                dropdownSearchDecoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(12, 2, 0, 0),
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0x331A202E)),
                                      borderRadius: BorderRadius.circular(12),
                                    )),
                                searchBoxDecoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.green))),
                                mode: Mode.DIALOG,
                                showSelectedItem: true,
                                items: state.addUpdatePet!.petCategory ==
                                        PetCategory.DOG
                                    ? state.petBreeds!.listOfDogBreed
                                    : state.petBreeds!.listOfCatBreed,
                                itemAsString: (breed) => breed.name,
                                hint: "Choose Pet's Breed",
                                selectedItem:
                                    state.addUpdatePet!.subCategory == null
                                        ? null
                                        : state.addUpdatePet!.subCategory,
                                onChanged: (value) {
                                  BlocProvider.of<PetProfileBloc>(context)
                                      .petBreedChanged(value);
                                },
                                compareFn: (i, s) {
                                  return true;
                                },
                                showSearchBox: true,
                              ),
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
                            hint: 'Years',
                            inputType: TextInputType.number,
                            value: (state.addUpdatePet!.age ?? "").toString(),
                            onDataFilled: (data) =>
                                BlocProvider.of<PetProfileBloc>(context)
                                    .petAgeChanged(data),
                            showError: state.errorAgeIsMissing,
                          )),
                          SizedBox(
                            width: 7,
                          ),
                          Expanded(
                              child: UserDetailInput(
                            heading: 'Weight',
                            required: true,
                            hint: 'Kg',
                            inputType: TextInputType.number,
                            value:
                                (state.addUpdatePet!.weight ?? "").toString(),
                            onDataFilled: (data) =>
                                BlocProvider.of<PetProfileBloc>(context)
                                    .petWeightChanged(data),
                            showError: state.errorWeightIsMissing,
                          )),
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
                            selected: state.addUpdatePet!.aggression ==
                                Aggression.LOW,
                            onSelected: () {
                              BlocProvider.of<PetProfileBloc>(context)
                                  .petAggressionChanged(Aggression.LOW);
                            },
                          ),
                          OptionsChip(
                            title: 'Medium',
                            selected: state.addUpdatePet!.aggression ==
                                Aggression.MEDIUM,
                            onSelected: () {
                              BlocProvider.of<PetProfileBloc>(context)
                                  .petAggressionChanged(Aggression.MEDIUM);
                            },
                          ),
                          OptionsChip(
                            title: 'High',
                            selected: state.addUpdatePet!.aggression ==
                                Aggression.HIGH,
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
                          height: 50,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.all(0)),
                              onPressed: () {
                                if (!state.addingPet)
                                  BlocProvider.of<PetProfileBloc>(context)
                                      .createNewPet(fromPopup: true);
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
            ),
          ),
        ],
      ),
    );
  }
}
