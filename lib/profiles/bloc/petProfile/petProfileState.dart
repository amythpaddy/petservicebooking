import 'package:the_pet_nest/konstants/enums.dart';
import 'package:the_pet_nest/profiles/model/getPetListModel.dart';
import 'package:the_pet_nest/profiles/model/petBreedModel.dart';

class PetProfileState {
  PetList? petList;
  PetDetail? addUpdatePet;
  PetBreeds? petBreeds;
  final bool petCreated;
  final bool petUpdated;
  final bool error;
  final bool addingPet;
  final bool updatingPet;

  PetProfileState(
      {this.petList,
      this.addUpdatePet,
      this.petBreeds,
      this.petCreated = false,
      this.petUpdated = false,
      this.addingPet = false,
      this.updatingPet = false,
      this.error = false}) {
    petList = this.petList ?? PetList();
    addUpdatePet = this.addUpdatePet ?? PetDetail();
    petBreeds = this.petBreeds ?? PetBreeds();
  }

  PetProfileState copyWith(
      {PetList? petList,
      PetDetail? addUpdatePet,
      PetBreeds? petBreeds,
      bool? petCreated,
      bool? petUpdated,
      bool? addingPet,
      bool? updatingPet,
      bool? error}) {
    return PetProfileState(
        petList: petList ?? this.petList,
        addUpdatePet: addUpdatePet ?? this.addUpdatePet,
        petBreeds: petBreeds ?? this.petBreeds,
        petCreated: petCreated ?? this.petCreated,
        petUpdated: petUpdated ?? this.petUpdated,
        addingPet: addingPet ?? this.addingPet,
        updatingPet: addingPet ?? this.addingPet,
        error: error ?? this.error);
  }
}

class PetDetail {
  String name;
  Aggression aggression;
  Gender gender;
  int age;
  double weight;
  int vaccine;
  BreedDetail? subCategory;
  PetCategory petCategory;
  PetDetail(
      {this.name = '',
      this.aggression = Aggression.HIGH,
      this.gender = Gender.FEMALE,
      this.age = 0,
      this.weight = 0,
      this.vaccine = 0,
      this.petCategory = PetCategory.DOG,
      this.subCategory});
}
