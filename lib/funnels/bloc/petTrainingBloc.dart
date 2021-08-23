import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_pet_nest/addressBook/model/addressBookModel.dart';
import 'package:the_pet_nest/funnels/bloc/funnelEvent.dart';
import 'package:the_pet_nest/funnels/bloc/funnelState.dart';
import 'package:the_pet_nest/konstants/enums.dart';
import 'package:the_pet_nest/profiles/model/getPetListModel.dart';

class PetTrainingBloc extends Bloc<FunnelEvent, FunnelState> {
  Address? _address;
  CustomerPet? _petData;
  FunnelScreens _currentScreen = FunnelScreens.SCREEN_ADDRESS_SELECTION;

  PetTrainingBloc(FunnelState initialState) : super(initialState) {
    add(FunnelEvent.UPDATE_PROGRESS_INDICATOR);
  }
  static const _TOTAL_SCREENS = 7;
  double _progressIndicator = 1 / _TOTAL_SCREENS;

  void setAddress(Address? address) {
    _address = address;
  }

  void openAddressSelectionScreen() {
    _currentScreen = FunnelScreens.SCREEN_ADDRESS_SELECTION;
    _progressIndicator = 1 / _TOTAL_SCREENS;
    add(FunnelEvent.OPEN_SCREEN_ADDRESS_SELECTION);
  }

  void openPetSelectionScreen() {
    if (_address == null) {
      add(FunnelEvent.ADDRESS_NOT_SELECTED);
    } else {
      _currentScreen = FunnelScreens.SCREEN_PET_SELECTION;
      _progressIndicator = 2 / _TOTAL_SCREENS;
      add(FunnelEvent.OPEN_SCREEN_PET_SELECTION);
    }
  }

  void setPet(CustomerPet petData) {
    _petData = petData;
  }

  void openPackageSelectionScreen() {
    if (_petData == null) {
      add(FunnelEvent.PET_NOT_SELECTED);
    } else {
      _currentScreen = FunnelScreens.SCREEN_PACKAGE_SELECTION;
      _progressIndicator = 3 / _TOTAL_SCREENS;
      add(FunnelEvent.OPEN_SCREEN_PACKAGE_SELECTION);
    }
  }

  void goBack() {
    switch (_currentScreen) {
      case FunnelScreens.SCREEN_ADDRESS_SELECTION:
        add(FunnelEvent.CLOSE_FUNNEL);
        break;
      case FunnelScreens.SCREEN_PACKAGE_SELECTION:
        openPetSelectionScreen();
        break;
      case FunnelScreens.SCREEN_PET_SELECTION:
        openAddressSelectionScreen();
        break;
    }
  }

  @override
  Stream<FunnelState> mapEventToState(FunnelEvent event) async* {
    if (event == FunnelEvent.OPEN_SCREEN_ADDRESS_SELECTION) {
      yield state.copyWith(
          progressIndicator: _progressIndicator, currentScreen: _currentScreen);
    }
    if (event == FunnelEvent.UPDATE_PROGRESS_INDICATOR) {
      yield state.copyWith(progressIndicator: _progressIndicator);
    } else if (event == FunnelEvent.OPEN_SCREEN_PET_SELECTION) {
      yield state.copyWith(
          currentScreen: _currentScreen,
          progressIndicator: _progressIndicator,
          citySlug: _address!.citySlug);
    } else if (event == FunnelEvent.ADDRESS_NOT_SELECTED) {
      yield state.copyWith(
          showError: true, errorMessage: "No Address Selected");
    } else if (event == FunnelEvent.OPEN_SCREEN_PACKAGE_SELECTION) {
      yield state.copyWith(
          currentScreen: _currentScreen,
          progressIndicator: _progressIndicator,
          petCategory: _petData!.subcategory!.name == "cat"
              ? PetCategory.CAT
              : PetCategory.DOG);
    } else if (event == FunnelEvent.PET_NOT_SELECTED) {
      yield state.copyWith(showError: true, errorMessage: "No Pet Selected");
    } else if (event == FunnelEvent.CLOSE_FUNNEL) {
      state.copyWith(closeThisFunnel: true);
    }
  }
}
