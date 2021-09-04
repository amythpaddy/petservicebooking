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
import 'package:the_pet_nest/utils/utils.dart';

class AddPetProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add Profile',
          style: kAppBarTitleStyle,
        ),
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: kAppBackgroundColor,
        elevation: 0,
      ),
      backgroundColor: kAppBackgroundColor,
      body: BlocProvider(
        create: (_) => PetProfileBloc(PetProfileState()),
        child: BlocListener<PetProfileBloc, PetProfileState>(
          listener: (listenerContext, state) {
            if (state.petBreeds == null) {
              BlocProvider.of<PetProfileBloc>(listenerContext).getPetBreed();
            }
            if (state.addUpdatePet == null) {
              BlocProvider.of<PetProfileBloc>(listenerContext).initAddPet();
            }
            if (state.error) {
              showSnackbar(context: context);
            }
            if (state.petCreated) {
              Navigator.pop(context);
            }
          },
          child: Container(
            margin: EdgeInsets.all(23),
            child: SingleChildScrollView(
                child: BlocBuilder<PetProfileBloc, PetProfileState>(
              builder: (context, state) {
                return state.addUpdatePet == null
                    ? Center(
                        child: CircularProgressIndicator(
                          color: kAppIconColor,
                        ),
                      )
                    : Column(
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
                                        border: Border.all(
                                            color: Color(0x77000000)),
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
                                onDataFilled: (String value) {
                                  BlocProvider.of<PetProfileBloc>(context)
                                      .petNameChanged(value);
                                },
                                value: state.addUpdatePet!.name,
                                showError: state.errorNameIsMissing,
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
                                selected:
                                    state.addUpdatePet!.gender == Gender.MALE,
                                onSelected: () {
                                  BlocProvider.of<PetProfileBloc>(context)
                                      .petGenderChanged(Gender.MALE);
                                },
                              ),
                              OptionsChip(
                                title: 'Female',
                                selected:
                                    state.addUpdatePet!.gender == Gender.FEMALE,
                                onSelected: () {
                                  BlocProvider.of<PetProfileBloc>(context)
                                      .petGenderChanged(Gender.FEMALE);
                                },
                              ),
                              // OptionsChip(
                              //   title: 'None',
                              //   selected: state.addUpdatePet!.gender == Gender.NONE,
                              //   onSelected: () {
                              //     BlocProvider.of<PetProfileBloc>(context)
                              //         .petGenderChanged(Gender.NONE);
                              //   },
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: 19,
                          ),
                          Heading(
                            heading: 'Category',
                            required: true,
                          ),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: state.errorCategoryIsMissing
                                        ? Colors.redAccent
                                        : Colors.transparent)),
                            child: DropdownSearch<String>(
                              mode: Mode.BOTTOM_SHEET,
                              showSelectedItem: true,
                              items: ['Dog', 'Cat'],
                              selectedItem: 'Dog',
                              // itemAsString: (breed) => breed.name,
                              hint: "Choose Pet's Category",
                              onChanged: (value) =>
                                  BlocProvider.of<PetProfileBloc>(context)
                                      .petCategoryChanged(value == 'Dog'
                                          ? PetCategory.DOG
                                          : PetCategory.CAT),
                              compareFn: (i, s) {
                                return true;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 19,
                          ),
                          Heading(
                            heading: 'Breed',
                            required: true,
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
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: state.errorBreedIsMissing
                                              ? Colors.redAccent
                                              : Colors.transparent)),
                                  child: DropdownSearch<BreedDetail>(
                                    mode: Mode.BOTTOM_SHEET,
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
                            height: 19,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: UserDetailInput(
                                heading: 'Age',
                                required: true,
                                inputType: TextInputType.number,
                                value:
                                    (state.addUpdatePet!.age ?? "").toString(),
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
                                inputType: TextInputType.number,
                                value: (state.addUpdatePet!.weight ?? "")
                                    .toString(),
                                onDataFilled: (data) =>
                                    BlocProvider.of<PetProfileBloc>(context)
                                        .petWeightChanged(data),
                                showError: state.errorWeightIsMissing,
                              )),
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
                            height: 40,
                          ),
                          Container(
                              width: double.infinity,
                              decoration: kActiveButtonContainerStyle,
                              child: TextButton(
                                  onPressed: () {
                                    if (!state.addingPet)
                                      BlocProvider.of<PetProfileBloc>(context)
                                          .createNewPet();
                                  },
                                  child: state.addingPet
                                      ? CircularProgressIndicator(
                                          color: kAppIconColor,
                                        )
                                      : Text(
                                          'Submit',
                                          style: kActiveButtonTextStyle,
                                        )))
                        ],
                      );
              },
            )),
          ),
        ),
      ),
    );
  }

  Future<List<BreedDetail>> getItemList(
      String filter, PetBreeds petBreeds) async {
    List<BreedDetail> itemList = [];

    petBreeds.listOfDogBreed.forEach((element) {
      if (element.name.contains(filter)) itemList.add(element);
    });
    return itemList;
  }
}
