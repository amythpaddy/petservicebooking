import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:the_pet_nest/config/sizeConfig.dart';
import 'package:the_pet_nest/dashboard/component/addPetPopup/component/petInfoModal.dart';
import 'package:the_pet_nest/dashboard/component/addPetPopup/component/petSelectModal.dart';
import 'package:the_pet_nest/konstants/values.dart';

import 'component/addedPetModal.dart';

class AddPetPopup extends StatefulWidget {
  @override
  _AddPetPopupState createState() => _AddPetPopupState();
}

enum Screens { SELECT_PET_SCREEN, PET_INFO_PAGE, ADDED_PET_PAGE }

class _AddPetPopupState extends State<AddPetPopup> {
  Screens currentScreen = Screens.SELECT_PET_SCREEN;
  late Widget body;
  String phoneNumber = '';
  final double selectPetHeight = 445;
  final double petInfoHeight = 672;
  final double addedPetHeight = 436;

  double heightProp = 445;

  void switchScreen() {}

  void selectPetScreenResponse(String response) {
    if (true)
      setState(() {
        currentScreen = Screens.PET_INFO_PAGE;
        heightProp = petInfoHeight;
      });
  }

  void petInfoScreenResponse(String response) {
    if (response == kPopupAddedPetList) {
      setState(() {
        currentScreen = Screens.ADDED_PET_PAGE;
        heightProp = addedPetHeight;
      });
    }
  }

  void addedPetScreenResponse(String response) {
    if (response == kPopupSelectPetType) {
      setState(() {
        currentScreen = Screens.SELECT_PET_SCREEN;
        heightProp = selectPetHeight;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (currentScreen) {
      case Screens.SELECT_PET_SCREEN:
        body = PetSelectModal(
          selectPetScreenResponse: selectPetScreenResponse,
        );
        break;
      case Screens.PET_INFO_PAGE:
        body = PetInfoModal(
          petInfoScreenResponse: petInfoScreenResponse,
        );
        break;
      case Screens.ADDED_PET_PAGE:
        body = AddedPetModal(addedPetScreenResponse: addedPetScreenResponse);
        break;
    }
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AnimatedContainer(
              duration: Duration(milliseconds: 250),
              height: heightProp,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22),
                      topRight: Radius.circular(22))),
              child: body),
        ],
      ),
    );
  }
}
