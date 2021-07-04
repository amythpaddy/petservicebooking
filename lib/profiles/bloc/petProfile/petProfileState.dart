import 'package:the_pet_nest/konstants/enums.dart';
import 'package:the_pet_nest/konstants/values.dart';
import 'package:the_pet_nest/profiles/model/getPetListModel.dart';
import 'package:the_pet_nest/profiles/model/petBreedModel.dart';

class PetProfileState {
  PetDataStore? petList;
  PetDetailForUpload? addUpdatePet;
  PetBreeds? petBreeds;
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
      this.error = false}) {
    petList = this.petList ?? PetDataStore();
    addUpdatePet = this.addUpdatePet ?? PetDetailForUpload();
    petBreeds = this.petBreeds ?? PetBreeds();
  }

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
      bool? error}) {
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
        error: error ?? this.error);
  }
}

class PetDetailForUpload {
  String name;
  Aggression aggression;
  Gender gender;
  int age;
  double weight;
  int vaccine;
  BreedDetail? subCategory;
  PetCategory petCategory;
  PetDetailForUpload(
      {this.name = '',
      this.aggression = Aggression.HIGH,
      this.gender = Gender.FEMALE,
      this.age = 0,
      this.weight = 0,
      this.vaccine = 0,
      this.petCategory = PetCategory.DOG,
      this.subCategory});

  static PetDetailForUpload fromPetStore(CustomerPet petDetail) {
    Aggression agg = Aggression.HIGH;
    switch (petDetail.aggression) {
      case "high":
        agg = Aggression.HIGH;
        break;
      case "medium":
        agg = Aggression.MEDIUM;
        break;
      case "low":
        agg = Aggression.LOW;
        break;
    }

    Gender gender;
    switch (petDetail.gender) {
      case "male":
        gender = Gender.MALE;
        break;
      case "female":
        gender = Gender.FEMALE;
        break;
    }
    late BreedDetail breedDetail;
    if (petDetail.category!.name == 'dog') {
      breedDetail = DogBreed(
          id: petDetail.subcategory!.id!, name: petDetail.subcategory!.name!);
    } else {
      breedDetail = CatBreed(
          id: petDetail.subcategory!.id!, name: petDetail.subcategory!.name!);
    }

    return PetDetailForUpload(
        name: petDetail.name!,
        aggression: agg,
        age: petDetail.age!,
        gender: petDetail.gender == "male" ? Gender.MALE : Gender.FEMALE,
        weight: petDetail.weight!,
        vaccine: petDetail.vaccinations == true ? 1 : 0,
        petCategory: petDetail.category!.name == 'dog'
            ? PetCategory.DOG
            : PetCategory.CAT,
        subCategory: breedDetail);
  }
}
