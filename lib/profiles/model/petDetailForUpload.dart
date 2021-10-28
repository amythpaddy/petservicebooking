import 'package:equatable/equatable.dart';
import 'package:the_pet_nest/konstants/enums.dart';
import 'package:the_pet_nest/profiles/model/petBreedModel.dart';

import 'getPetListModel.dart';

class PetDetailForUpload extends Equatable {
  String name;
  Aggression aggression;
  Gender gender;
  int? age;
  double? weight;
  int vaccine;
  BreedDetail? subCategory;
  PetCategory petCategory;
  String image;
  PetDetailForUpload(
      {this.name = '',
      this.aggression = Aggression.HIGH,
      this.gender = Gender.FEMALE,
      this.age,
      this.weight,
      this.vaccine = 0,
      this.petCategory = PetCategory.DOG,
      this.subCategory,
      this.image = ''});

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
        image: petDetail.images ?? '',
        vaccine: petDetail.vaccinations == true ? 1 : 0,
        petCategory: petDetail.category!.name == 'dog'
            ? PetCategory.DOG
            : PetCategory.CAT,
        subCategory: breedDetail);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        name,
        aggression,
        gender,
        age,
        weight,
        vaccine,
        subCategory,
        petCategory
      ];
}
