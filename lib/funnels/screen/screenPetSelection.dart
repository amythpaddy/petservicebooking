import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_pet_nest/config/sizeConfig.dart';
import 'package:the_pet_nest/dashboard/component/addPetPopup/addPetPopup.dart';
import 'package:the_pet_nest/funnels/component/selectAddedPetComponent.dart';
import 'package:the_pet_nest/funnels/interfaces/petSelectionInterface.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/styles.dart';
import 'package:the_pet_nest/profiles/bloc/petProfile/petProfileBloc.dart';
import 'package:the_pet_nest/profiles/bloc/petProfile/petProfileState.dart';

class ScreenPetSelection extends StatelessWidget {
  const ScreenPetSelection({Key? key, required this.onPetSelected})
      : super(key: key);
  final PetSelectionInterface onPetSelected;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          height: SizeConfig.blockSizeVertical * 85,
          color: kAppBackgroundColor,
          margin: EdgeInsets.symmetric(horizontal: 18.46),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 27.37,
                ),
                Text(
                  'Who are we helping?',
                  style: kFunnelScreenHeadingTextStyle,
                ),
                SizedBox(
                  height: 33.62,
                ),
                BlocBuilder<PetProfileBloc, PetProfileState>(
                  builder: (blocContext, state) {
                    if (state.petList == null) {
                      BlocProvider.of<PetProfileBloc>(blocContext).getPetData();
                    }
                    return state.petList == null
                        ? Center(
                            child: CircularProgressIndicator(
                              color: kAppIconColor,
                            ),
                          )
                        : Container(
                            height: state.petList!.petDataStore.length == 0
                                ? 0
                                : 160,
                            child: Center(
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: state.petList!.petDataStore.length,
                                  itemBuilder: (context, index) {
                                    return TextButton(
                                      onPressed: () {
                                        onPetSelected.petSelected(blocContext,
                                            state.petList!.petDataStore[index]);
                                        BlocProvider.of<PetProfileBloc>(
                                                blocContext)
                                            .petSelectedByUser(index);
                                      },
                                      child: SelectAddedPetCard(
                                        name: state
                                            .petList!.petDataStore[index].name!,
                                        image: '',
                                        breed: state
                                            .petList!
                                            .petDataStore[index]
                                            .subcategory!
                                            .name!,
                                        selected: index ==
                                            state.petSelectedByUserIndex,
                                      ),
                                    );
                                  }),
                            ),
                          );
                  },
                ),
                SizedBox(
                  height: 47.14,
                ),
                Center(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: kActiveButtonColor,
                        borderRadius: BorderRadius.all(Radius.circular(51)),
                        boxShadow: [kContainerBoxShadow]),
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => Theme(
                            data: ThemeData(canvasColor: Colors.transparent),
                            child: FractionallySizedBox(
                              heightFactor: 1,
                              child: AddPetPopup(),
                            ),
                          ),
                        );
                      },
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
                ),
                SizedBox(
                  height: 48.37,
                ),
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: 'Additional Note ',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          height: 1.5)),
                  TextSpan(
                      text: ' (Optional)',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          height: 1.5))
                ])),
                SizedBox(
                  height: 7.11,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [kContainerBoxShadow]),
                  height: 84,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    style: TextStyle(fontSize: 14),
                    minLines: 2,
                    maxLines: 10,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        hintText: 'Write a note for Groomer',
                        border: InputBorder.none,
                        fillColor: Colors.white),
                  ),
                ),
                Expanded(child: Container()),
                TextButton(
                  onPressed: () {
                    onPetSelected.onPetSelectionComplete(context);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                    decoration: kActiveButtonContainerStyle,
                    child: Text(
                      'Next',
                      textAlign: TextAlign.center,
                      style: kActiveButtonTextStyle,
                    ),
                  ),
                )
              ])),
    );
  }
}
