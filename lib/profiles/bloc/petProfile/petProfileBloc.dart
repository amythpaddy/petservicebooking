import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_pet_nest/konstants/endpoints.dart';
import 'package:the_pet_nest/konstants/enums.dart';
import 'package:the_pet_nest/profiles/bloc/petProfile/petProfileEvent.dart';
import 'package:the_pet_nest/profiles/bloc/petProfile/petProfileState.dart';
import 'package:the_pet_nest/profiles/model/createPetModel.dart';
import 'package:the_pet_nest/profiles/model/getPetListModel.dart';
import 'package:the_pet_nest/profiles/model/petBreedModel.dart';
import 'package:the_pet_nest/utils/ApiCaller.dart';

class PetProfileBloc extends Bloc<PetProfileEvent, PetProfileState> {
  PetProfileBloc(PetProfileState initialState) : super(initialState) {
    initSharedPreferences();
    getPetData();
    getPetBreed();
  }

  late PetBreeds petBreeds;
  PetList _petList = PetList();
  PetDetail _petDetail = PetDetail();
  late SharedPreferences prefs;
  void initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  void getPetBreed() async {
    var value = await ApiCaller.get(kUrlGetPetBreed);
    print(value.toString());
    ResponsePetBreed petBreedResponse = ResponsePetBreed.fromJson(value);
    petBreeds = new PetBreeds();
    petBreeds.initData(petBreedResponse);
    add(PetProfileEvent.PETS_BREED_FETCHED);
  }

  void getPetData() async {
    var value = await ApiCaller.get(kUrlGetPetData, withToken: true);
    print(value);
    _petList = PetList.fromJson(value);
  }

  void petNameChanged(String name) {
    _petDetail.name = name;
    add(PetProfileEvent.PET_DETAILS_CHANGED);
  }

  void petGenderChanged(Gender gender) {
    _petDetail.gender = gender;
    add(PetProfileEvent.PET_DETAILS_CHANGED);
  }

  void petAgeChanged(String age) {
    if (int.tryParse(age, radix: 10) != null) {
      _petDetail.age = int.parse(age, radix: 10);
      add(PetProfileEvent.PET_DETAILS_CHANGED);
    }
  }

  void petAggressionChanged(Aggression aggression) {
    _petDetail.aggression = aggression;
    add(PetProfileEvent.PET_DETAILS_CHANGED);
  }

  void petWeightChanged(String weight) {
    if (double.tryParse(weight) != null) {
      _petDetail.weight = double.parse(weight);
      add(PetProfileEvent.PET_DETAILS_CHANGED);
    }
  }

  void petVaccinationCountChanged(int vaccinationCount) {
    _petDetail.vaccine = vaccinationCount;
    add(PetProfileEvent.PET_DETAILS_CHANGED);
  }

  void petBreedChanged(BreedDetail breed) {
    _petDetail.subCategory = breed;
    add(PetProfileEvent.PET_DETAILS_CHANGED);
  }

  void addPetData(RequestPetData request) async {
    var value = await ApiCaller.post(kUrlGetUserData, request, withToken: true);
  }

  void createNewPet() async {
    RequestPetData data = RequestPetData.from(_petDetail);
    var value =
        await ApiCaller.post(kUrlCreatePet, data.toJson(), withToken: true);
    PetData petCreatedResponse = PetData.fromJson(value);
    if (petCreatedResponse.data != null) {
      if (_petList == null) {
        _petList = PetList();
      }
      _petList.add(petCreatedResponse);
      add(PetProfileEvent.PET_ADDED);
    } else
      add(PetProfileEvent.ERROR_RESPONSE);
  }

  @override
  Stream<PetProfileState> mapEventToState(PetProfileEvent event) async* {
    if (event == PetProfileEvent.PET_DETAILS_CHANGED) {
      yield state.copyWith(addUpdatePet: _petDetail);
    } else if (event == PetProfileEvent.PETS_BREED_FETCHED) {
      yield state.copyWith(petBreeds: petBreeds);
    } else if (event == PetProfileEvent.PET_ADDED) {
      yield state.copyWith(
          petCreated: true, addingPet: false, petList: _petList);
    } else if (event == PetProfileEvent.ERROR_RESPONSE) {
      yield state.copyWith(error: true, addingPet: false);
    }
  }
}
