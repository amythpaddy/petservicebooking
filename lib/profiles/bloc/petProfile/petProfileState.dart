import 'package:image_picker/image_picker.dart';
import 'package:the_pet_nest/konstants/enums.dart';
import 'package:the_pet_nest/konstants/values.dart';
import 'package:the_pet_nest/profiles/model/getPetListModel.dart';
import 'package:the_pet_nest/profiles/model/petBreedModel.dart';
import 'package:the_pet_nest/profiles/model/petDetailForUpload.dart';

class PetProfileState {
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
  final bool errorNameIsMissing;
  final bool errorCategoryIsMissing;
  final bool errorBreedIsMissing;
  final bool errorAgeIsMissing;
  final bool errorWeightIsMissing;
  final XFile? image;

  PetProfileState(
      {this.petList,
      this.addUpdatePet,
      this.petBreeds,
      this.petCreated = false,
      this.petUpdated = false,
      this.addingPet = false,
      this.updatingPet = false,
      this.fetchingPetData = false,
      this.appVersion = '...',
      this.petId = -1,
      this.currentScreen = PetPopupScreens.SELECT_PET_CATEGORY_SCREEN,
      this.showPetPopupScreens = true,
      this.modalHeight = kHeightPetPopupDefault,
      this.error = false,
      this.petSelectedByUserIndex = -1,
      this.errorNameIsMissing = false,
      this.errorCategoryIsMissing = false,
      this.errorBreedIsMissing = false,
      this.errorAgeIsMissing = false,
      this.errorWeightIsMissing = false,
      this.image});

  PetProfileState copyWith({
    PetDataStore? petList,
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
    int? petSelectedByUserIndex,
    bool? errorNameIsMissing,
    bool? errorCategoryIsMissing,
    bool? errorBreedIsMissing,
    bool? errorAgeIsMissing,
    bool? errorWeightIsMissing,
    XFile? image,
  }) {
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
          petSelectedByUserIndex ?? this.petSelectedByUserIndex,
      errorNameIsMissing: errorNameIsMissing ?? this.errorNameIsMissing,
      errorAgeIsMissing: errorAgeIsMissing ?? this.errorAgeIsMissing,
      errorBreedIsMissing: errorBreedIsMissing ?? this.errorBreedIsMissing,
      errorCategoryIsMissing:
          errorCategoryIsMissing ?? this.errorCategoryIsMissing,
      errorWeightIsMissing: errorWeightIsMissing ?? this.errorWeightIsMissing,
      image: image ?? this.image,
    );
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
        petSelectedByUserIndex,
        image
      ];
}
