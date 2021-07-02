import 'package:the_pet_nest/konstants/enums.dart';
import 'package:the_pet_nest/profiles/bloc/petProfile/petProfileState.dart';

class RequestPetData {
  final String name;
  final int categoryId;
  final int subCategoryId;
  final String gender;
  final int vaccination;
  final int aggression;
  final int? age;
  final double? weight;

  RequestPetData(
      {required this.name,
      required this.categoryId,
      required this.subCategoryId,
      required this.gender,
      required this.vaccination,
      required this.aggression,
      required this.age,
      required this.weight});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map();
    data['name'] = name;
    data['category_id'] = categoryId;
    data['subcategory_id'] = subCategoryId;
    data['gender'] = gender;
    data['vaccinations'] = vaccination;
    data['aggression'] = aggression;
    data['age'] = age;
    data['weight'] = weight;
    final Map<String, dynamic> requestBody = Map();
    requestBody["customer_pet"] = data;
    return requestBody;
  }

  static RequestPetData from(PetDetail detail) {
    int aggression = 0;
    switch (detail.aggression) {
      case Aggression.HIGH:
        aggression = 2;
        break;
      case Aggression.MEDIUM:
        aggression = 1;
        break;
    }
    return RequestPetData(
        name: detail.name,
        categoryId: detail.petCategory == PetCategory.DOG ? 1 : 2,
        subCategoryId: detail.subCategory!.id,
        gender: detail.gender == Gender.MALE ? 'male' : 'female',
        vaccination: detail.vaccine,
        age: detail.age,
        weight: detail.weight,
        aggression: aggression);
  }
}
