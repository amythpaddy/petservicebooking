import 'package:equatable/equatable.dart';
import 'package:the_pet_nest/konstants/enums.dart';
import 'package:the_pet_nest/konstants/values.dart';
import 'package:the_pet_nest/profiles/model/getPetListModel.dart';
import 'package:the_pet_nest/profiles/model/petBreedModel.dart';
import 'package:the_pet_nest/profiles/model/petDetailForUpload.dart';

class PetProfileState extends Equatable {
  late final PetDataStore? petList;
  late final PetDetailForUpload? addUpdatePet;
  late final PetBreeds? petBreeds;
  final bool petCreated;
  final bool petUpdated;
  final bool error;
  final bool addingPet;
  final bool updatingPet;
  final bool fetchingPetData;
  final String appVersion;
  final int petId;
  final PetPopupScreens currentScreen;
  final bool showPetPopupScreens;
  final double modalHeight;
  final int petSelectedByUserIndex;

  PetProfileState(
      {this.petList,
      this.addUpdatePet,
      this.petBreeds,
      this.petCreated = false,
      this.petUpdated = false,
      this.addingPet = false,
      this.updatingPet = false,
      this.fetchingPetData = true,
      this.appVersion = '...',
      this.petId = -1,
      this.currentScreen = PetPopupScreens.SELECT_PET_CATEGORY_SCREEN,
      this.showPetPopupScreens = false,
      this.modalHeight = kHeightPetPopupDefault,
      this.error = false,
      this.petSelectedByUserIndex = -1});

  PetProfileState copyWith(
      {PetDataStore? petList,
      PetDetailForUpload? addUpdatePet,
      PetBreeds? petBreeds,
      bool? petCreated,
      bool? petUpdated,
      bool? addingPet,
      bool? updatingPet,
      bool? fetchingPetData,
      String? appVersion,
      int? petId,
      PetPopupScreens? currentScreen,
      bool? showPetPopupScreen,
      double? modalHeight,
      bool? error,
      int? petSelectedByUserIndex}) {
    return PetProfileState(
        petList: petList ?? this.petList,
        addUpdatePet: addUpdatePet ?? this.addUpdatePet,
        petBreeds: petBreeds ?? this.petBreeds,
        petCreated: petCreated ?? this.petCreated,
        petUpdated: petUpdated ?? this.petUpdated,
        addingPet: addingPet ?? this.addingPet,
        updatingPet: addingPet ?? this.addingPet,
        fetchingPetData: fetchingPetData ?? this.fetchingPetData,
        appVersion: appVersion ?? this.appVersion,
        petId: petId ?? this.petId,
        currentScreen: currentScreen ?? this.currentScreen,
        showPetPopupScreens: showPetPopupScreen ?? this.showPetPopupScreens,
        modalHeight: modalHeight ?? this.modalHeight,
        error: error ?? this.error,
        petSelectedByUserIndex:
            petSelectedByUserIndex ?? this.petSelectedByUserIndex);
  }

  PetProfileState resetValues() {
    return PetProfileState(
      petList: petList,
      fetchingPetData: false,
      appVersion: appVersion,
    );
  }

  @override
  List<Object?> get props => [
        petList,
        addUpdatePet,
        petBreeds,
        petCreated,
        petUpdated,
        error,
        addingPet,
        updatingPet,
        fetchingPetData,
        appVersion,
        petId,
        currentScreen,
        showPetPopupScreens,
        modalHeight,
        petSelectedByUserIndex
      ];
}
