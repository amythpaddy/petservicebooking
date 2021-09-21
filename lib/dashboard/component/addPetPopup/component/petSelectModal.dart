import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_pet_nest/dashboard/component/addPetPopup/component/petOptionCheckbox.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/enums.dart';
import 'package:the_pet_nest/konstants/styles.dart';
import 'package:the_pet_nest/profiles/bloc/petProfile/petProfileBloc.dart';
import 'package:the_pet_nest/profiles/bloc/petProfile/petProfileState.dart';

class PetSelectModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        // constraints: BoxConstraints.expand(),
        margin: EdgeInsets.symmetric(horizontal: 20.5),
        color: Colors.transparent,
        child: BlocBuilder<PetProfileBloc, PetProfileState>(
          builder: (blocContext, state) {
            if (state.addUpdatePet == null) {
              BlocProvider.of<PetProfileBloc>(blocContext).initAddPet();
              return Center(
                child: CircularProgressIndicator(
                  color: kAppIconColor,
                ),
              );
            }
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
                      PetSelectCheckBox(
                          title: 'Cat',
                          image: 'assets/images/login/cat_image.svg',
                          selected: state.addUpdatePet!.petCategory ==
                              PetCategory.CAT,
                          onChanged: () {
                            BlocProvider.of<PetProfileBloc>(blocContext)
                                .petCategoryChanged(PetCategory.CAT);
                          }),
                      SizedBox(
                        width: 75,
                      ),
                      PetSelectCheckBox(
                          title: 'Dog',
                          image: 'assets/images/login/dog_image.svg',
                          selected: state.addUpdatePet!.petCategory ==
                              PetCategory.DOG,
                          onChanged: () {
                            BlocProvider.of<PetProfileBloc>(blocContext)
                                .petCategoryChanged(PetCategory.DOG);
                          })
                    ],
                  ),
                  SizedBox(
                    height: 51.27,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    decoration: kActiveButtonContainerStyle,
                    child: TextButton(
                      onPressed: () =>
                          BlocProvider.of<PetProfileBloc>(blocContext)
                              .showPetDetailScreen(),
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
                    child: TextButton(
                      onPressed: () =>
                          BlocProvider.of<PetProfileBloc>(blocContext)
                              .closePetDetailPopup(),
                      child: Text(
                        'Cancel',
                        textAlign: TextAlign.center,
                        style: kActiveButtonOutlineTextStyle,
                      ),
                    ),
                  )
                ]);
          },
        ));
  }
}
