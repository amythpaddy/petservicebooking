import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_pet_nest/config/sizeConfig.dart';
import 'package:the_pet_nest/dashboard/component/addPetPopup/component/petInfoModal.dart';
import 'package:the_pet_nest/dashboard/component/addPetPopup/component/petSelectModal.dart';
import 'package:the_pet_nest/konstants/enums.dart';
import 'package:the_pet_nest/profiles/bloc/petProfile/petProfileBloc.dart';
import 'package:the_pet_nest/profiles/bloc/petProfile/petProfileState.dart';
import 'package:the_pet_nest/utils/utils.dart';

import 'component/addedPetModal.dart';

class AddPetPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      //scaffold because the content is taking up all the space without Scaffold. Have to check why
      body: Column(
        // to bottom align the Container
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BlocProvider(
            create: (_) => PetProfileBloc(PetProfileState()),
            child: BlocListener<PetProfileBloc, PetProfileState>(
              listener: (blocContext, state) {
                if (state.error) {
                  showSnackbar(context: context);
                }
              },
              child: BlocBuilder<PetProfileBloc, PetProfileState>(
                builder: (blocContext, state) {
                  late Widget body;
                  if (!state.showPetPopupScreens) {
                    Navigator.pop(context);
                  }
                  switch (state.currentScreen) {
                    case PetPopupScreens.SELECT_PET_CATEGORY_SCREEN:
                      body = PetSelectModal();
                      break;
                    case PetPopupScreens.PET_INFO_PAGE:
                      body = PetInfoModal();
                      break;
                    case PetPopupScreens.ADDED_PET_PAGE:
                      body = AddedPetModal();
                      break;
                  }
                  return AnimatedContainer(
                      duration: Duration(milliseconds: 250),
                      height: state.modalHeight,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(22),
                              topRight: Radius.circular(22))),
                      child: body);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
