import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_pet_nest/konstants/endpoints.dart';
import 'package:the_pet_nest/konstants/enums.dart';
import 'package:the_pet_nest/konstants/values.dart';
import 'package:the_pet_nest/profiles/bloc/petProfile/petProfileEvent.dart';
import 'package:the_pet_nest/profiles/bloc/petProfile/petProfileState.dart';
import 'package:the_pet_nest/profiles/model/createPetModel.dart';
import 'package:the_pet_nest/profiles/model/getPetListModel.dart';
import 'package:the_pet_nest/profiles/model/petBreedModel.dart';
import 'package:the_pet_nest/utils/ApiCaller.dart';

class PetProfileBloc extends Bloc<PetProfileEvent, PetProfileState> {
  late PetBreeds _petBreeds;
  PetDataStore _petList = PetDataStore();
  PetDetailForUpload _petDetail = PetDetailForUpload();
  late String _version;
  int _id = -1;
  late SharedPreferences _prefs;
  int _selectedPetIndex = -1;

  PetProfileBloc(PetProfileState initialState) : super(initialState) {
    getAppVersion();
    initSharedPreferences();
    getPetData();
    getPetBreed();
  }

  void getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _version = packageInfo.version;
    add(PetProfileEvent.APP_VERSION_UPDATED);
  }

  void initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void getPetBreed() async {
    var value = await ApiCaller.get(kUrlGetPetBreed);
    ResponsePetBreed petBreedResponse = ResponsePetBreed.fromJson(value);
    _petBreeds = new PetBreeds();
    _petBreeds.initData(petBreedResponse);
    add(PetProfileEvent.PETS_BREED_FETCHED);
  }

  void getPetData() async {
    var value = await ApiCaller.get(kUrlGetPetData, withToken: true);
    _petList.getList(ResponseGetPet.fromJson(value));
    add(PetProfileEvent.PET_DETAILS_LOADED);
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

  void petCategoryChanged(PetCategory category) {
    _petDetail.petCategory = category;
    add(PetProfileEvent.PET_DETAILS_CHANGED);
  }

  void setId(id) {
    _id = id;
    _petDetail = PetDetailForUpload.fromPetStore(
        _petList.petDataStore.firstWhere((element) => element.id == id));
    print(_petDetail.name);
    add(PetProfileEvent.PET_ID_SET);
  }

  void openPetDetailPopup() {
    add(PetProfileEvent.SHOW_PET_POPUP);
  }

  void showPetCategoryScreen() {
    _petDetail = PetDetailForUpload();
    add(PetProfileEvent.SHOW_PET_CATEGORY_POPUP);
  }

  void showPetDetailScreen() {
    add(PetProfileEvent.SHOW_PET_DETAIL_POPUP);
  }

  void closePetDetailPopup() {
    add(PetProfileEvent.CANCEL_PET_POPUP);
  }

  void updatePetData() async {
    RequestPetData data = RequestPetData.from(_petDetail);
    var value = await ApiCaller.put('${kUrlUpdatePet}4', data, withToken: true);
    PetCURLModel petCreatedResponse = PetCURLModel.fromJson(value);
    if (petCreatedResponse.data != null) {
      _petList.petDataStore.removeWhere((element) => element.id == _id);
      _petList.addToList(petCreatedResponse);
      add(PetProfileEvent.PET_ADDED);
    } else
      add(PetProfileEvent.ERROR_RESPONSE);
  }

  void createNewPet() async {
    RequestPetData data = RequestPetData.from(_petDetail);
    var value =
        await ApiCaller.post(kUrlCreatePet, data.toJson(), withToken: true);
    PetCURLModel petCreatedResponse = PetCURLModel.fromJson(value);
    if (petCreatedResponse.data != null) {
      _petList.addToList(petCreatedResponse);
      add(PetProfileEvent.PET_ADDED);
      add(PetProfileEvent.SHOW_ADDED_PET_POPUP);
    } else
      add(PetProfileEvent.ERROR_RESPONSE);
  }

  void petSelectedByUser(int index) {
    _selectedPetIndex = index;
    add(PetProfileEvent.PET_SELECTED_BY_USER);
  }

  void resetState() {
    add(PetProfileEvent.RESET_STATE_VALUE);
  }

  @override
  Stream<PetProfileState> mapEventToState(PetProfileEvent event) async* {
    if (event == PetProfileEvent.PET_DETAILS_CHANGED) {
      yield state.copyWith(addUpdatePet: _petDetail);
    } else if (event == PetProfileEvent.PETS_BREED_FETCHED) {
      yield state.copyWith(petBreeds: _petBreeds);
    } else if (event == PetProfileEvent.PET_ADDED) {
      yield state.copyWith(
          petCreated: true, addingPet: false, petList: _petList);
    } else if (event == PetProfileEvent.ERROR_RESPONSE) {
      yield state.copyWith(error: true, addingPet: false);
    } else if (event == PetProfileEvent.PET_DETAILS_LOADED) {
      yield state.copyWith(petList: _petList, fetchingPetData: false);
    } else if (event == PetProfileEvent.APP_VERSION_UPDATED) {
      yield state.copyWith(appVersion: _version);
    } else if (event == PetProfileEvent.PET_ID_SET) {
      yield state.copyWith(petId: _id, addUpdatePet: _petDetail);
    } else if (event == PetProfileEvent.UPDATING_PET_DETAIL) {
      yield state.copyWith(updatingPet: true);
    } else if (event == PetProfileEvent.PET_UPDATED) {
      yield state.copyWith(
          petUpdated: true, updatingPet: false, petList: _petList);
    } else if (event == PetProfileEvent.SHOW_PET_POPUP) {
      yield state.copyWith(
          showPetPopupScreen: true,
          currentScreen: PetPopupScreens.SELECT_PET_CATEGORY_SCREEN,
          modalHeight: kHeightPetPopupSelectPet);
    } else if (event == PetProfileEvent.SHOW_PET_CATEGORY_POPUP) {
      yield state.copyWith(
          currentScreen: PetPopupScreens.SELECT_PET_CATEGORY_SCREEN,
          modalHeight: kHeightPetPopupSelectPet);
    } else if (event == PetProfileEvent.SHOW_PET_DETAIL_POPUP) {
      yield state.copyWith(
          currentScreen: PetPopupScreens.PET_INFO_PAGE,
          modalHeight: kHeightPetPopupPetInfo);
    } else if (event == PetProfileEvent.SHOW_ADDED_PET_POPUP) {
      yield state.copyWith(
          currentScreen: PetPopupScreens.ADDED_PET_PAGE,
          modalHeight: kHeightPetPopupAddedPet);
    } else if (event == PetProfileEvent.CANCEL_PET_POPUP) {
      yield state.copyWith(
          showPetPopupScreen: false,
          currentScreen: PetPopupScreens.SELECT_PET_CATEGORY_SCREEN);
    } else if (event == PetProfileEvent.PET_SELECTED_BY_USER) {
      yield state.copyWith(petSelectedByUserIndex: _selectedPetIndex);
    } else if (event == PetProfileEvent.RESET_STATE_VALUE) {
      yield state.resetValues();
    }
  }
}
