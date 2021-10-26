import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_pet_nest/dashboard/component/addPetPopup/component/addedPetCard.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/styles.dart';
import 'package:the_pet_nest/profiles/bloc/petProfile/petProfileBloc.dart';
import 'package:the_pet_nest/profiles/bloc/petProfile/petProfileState.dart';

class AddedPetModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PetProfileBloc, PetProfileState>(
      builder: (blocContext, state) {
        return Container(
            margin: EdgeInsets.symmetric(horizontal: 20.5),
            width: double.infinity,
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
                        color: kAppIconColor,
                        borderRadius: BorderRadius.circular(1)),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Container(
                    height: 150,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: state.petList!.petDataStore.length,
                        itemBuilder: (context, index) {
                          return AddedPetCard(
                            name: state.petList!.petDataStore[index].name!,
                            image: 'assets/images/profile/dog_avatar.png',
                            breed: state.petList!.petDataStore[index]
                                .subcategory!.name!,
                          );
                        }),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: kActiveButtonColor,
                        borderRadius: BorderRadius.all(Radius.circular(51)),
                        boxShadow: [kContainerBoxShadow]),
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
                      onPressed: () => BlocProvider.of<PetProfileBloc>(context)
                          .showPetCategoryScreen(),
                      child: Text(
                        'Add another pet',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 77,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: kActiveButtonContainerStyle,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
                      onPressed: () => BlocProvider.of<PetProfileBloc>(context)
                          .closePetDetailPopup(),
                      child: Text(
                        'Close',
                        style: kActiveButtonTextStyle,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 33,
                  )
                ]));
      },
    );
  }
}
