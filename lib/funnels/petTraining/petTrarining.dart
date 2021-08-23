import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_pet_nest/addressBook/bloc/addressBookBloc.dart';
import 'package:the_pet_nest/addressBook/bloc/addressBookState.dart';
import 'package:the_pet_nest/addressBook/model/addressBookModel.dart';
import 'package:the_pet_nest/funnels/bloc/dateTimeBloc/dateTimeBloc.dart';
import 'package:the_pet_nest/funnels/bloc/dateTimeBloc/dateTimeState.dart';
import 'package:the_pet_nest/funnels/bloc/funnelState.dart';
import 'package:the_pet_nest/funnels/bloc/packageBloc/packageBloc.dart';
import 'package:the_pet_nest/funnels/bloc/packageBloc/packageState.dart';
import 'package:the_pet_nest/funnels/bloc/petTrainingBloc.dart';
import 'package:the_pet_nest/funnels/interfaces/AddressSelectionInterface.dart';
import 'package:the_pet_nest/funnels/interfaces/dateTimeSelectionInterface.dart';
import 'package:the_pet_nest/funnels/interfaces/packageSelectionInterface.dart';
import 'package:the_pet_nest/funnels/interfaces/petSelectionInterface.dart';
import 'package:the_pet_nest/funnels/model/packageDetailApiResponseModel.dart';
import 'package:the_pet_nest/funnels/screen/ScreenAddressSelection.dart';
import 'package:the_pet_nest/funnels/screen/screenPackageSelection.dart';
import 'package:the_pet_nest/funnels/screen/screenPetSelection.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/enums.dart';
import 'package:the_pet_nest/profiles/bloc/petProfile/petProfileBloc.dart';
import 'package:the_pet_nest/profiles/bloc/petProfile/petProfileState.dart';
import 'package:the_pet_nest/profiles/model/getPetListModel.dart';
import 'package:the_pet_nest/utils/utils.dart';

class PetTrainingService extends StatelessWidget
    implements
        AddressSelectionInterface,
        PetSelectionInterface,
        PackageSelectionInterface,
        DateTimeSelectionInterface {
  const PetTrainingService({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // String
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => AddressBookBloc(initialState: AddressBookState())),
          BlocProvider(create: (_) => PetTrainingBloc(FunnelState())),
          BlocProvider(create: (_) => PetProfileBloc(PetProfileState())),
          BlocProvider(create: (_) => PackageBloc(PackageState())),
          BlocProvider(create: (_) => DateTimeBloc(DateTimeState())),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<PetTrainingBloc, FunnelState>(
                listener: (blocContext, state) {
              if (state.closeThisFunnel) {
                Navigator.pop(context);
              } else if (state.showError) {
                showSnackbar(context: blocContext, message: state.errorMessage);
              }
            })
          ],
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: kAppBackgroundAltGray,
              leading: BlocBuilder<PetTrainingBloc, FunnelState>(
                builder: (blocContext, state) {
                  return IconButton(
                    onPressed: () {
                      BlocProvider.of<PetTrainingBloc>(blocContext).goBack();
                    },
                    icon: Icon(Icons.arrow_back),
                  );
                },
              ),
            ),
            backgroundColor: kAppBackgroundAltGray,
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                BlocBuilder<PetTrainingBloc, FunnelState>(
                    builder: (blocContext, state) {
                  late Widget body;
                  switch (state.currentScreen) {
                    case FunnelScreens.SCREEN_ADDRESS_SELECTION:
                      body = ScreenAddressSelection(onAddressSelection: this);
                      break;
                    case FunnelScreens.SCREEN_PET_SELECTION:
                      body = ScreenPetSelection(onPetSelected: this);
                      break;
                    case FunnelScreens.SCREEN_PACKAGE_SELECTION:
                      body = ScreenPackageSelection(
                        onPackageSelected: this,
                        petCategory: state.petCategory,
                        city: state.citySlug,
                        currentFunnel: FunnelType.PET_TRAINING,
                      );
                      break;
                  }
                  return Expanded(
                    child: Column(
                      children: [
                        LinearProgressIndicator(
                          backgroundColor: kAppBackgroundAltGray,
                          color: kAppIconColor,
                          value: state.progressIndicator,
                        ),
                        body
                      ],
                    ),
                  );
                }),
                // Text(textTest)
              ],
            ),
          ),
        ));
  }

  @override
  void onAddressSelected(blocContext, Address? address) {
    BlocProvider.of<PetTrainingBloc>(blocContext).setAddress(address);
  }

  @override
  void onAddressSelectionComplete(blocContext) {
    BlocProvider.of<PetTrainingBloc>(blocContext).openPetSelectionScreen();
  }

  @override
  void onNoteUpdated(blocContext, String note) {
    // TODO: implement onPetSelectionComplete
  }

  @override
  void onPetSelectionComplete(blocContext) {
    BlocProvider.of<PetTrainingBloc>(blocContext).openPackageSelectionScreen();
  }

  @override
  void petSelected(blocContext, CustomerPet petData) {
    BlocProvider.of<PetTrainingBloc>(blocContext).setPet(petData);
  }

  @override
  void dateSelected(blocContext, String date) {
    // TODO: implement dateSelected
  }

  @override
  void onPackageSelectionComplete(blocContext) {
    // TODO: implement onPackageAndDateTimeSelectionComplete
  }

  @override
  void packageSelected(blocContext, PackageDetailModel packageDetail) {
    // TODO: implement packageSelected
  }

  @override
  void timeSelected(blocContext, String time) {
    // TODO: implement timeSelected
  }

  @override
  void onDateTimeSelectionComplete(blocContext) {
    // TODO: implement onPackageSelectionComplete
  }
}
