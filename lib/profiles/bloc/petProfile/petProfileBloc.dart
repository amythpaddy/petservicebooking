import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
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
import 'package:the_pet_nest/profiles/model/petDetailForUpload.dart';
import 'package:the_pet_nest/utils/ApiCaller.dart';

class PetProfileBloc extends Bloc<PetProfileEvent, PetProfileState> {
  late PetBreeds _petBreeds;
  PetDataStore _petList = PetDataStore();
  PetDetailForUpload _petDetail = PetDetailForUpload();
  late String _version;
  int _id = -1;
  late SharedPreferences _prefs;
  int _selectedPetIndex = -1;
  XFile? _image;

  PetProfileBloc(PetProfileState initialState) : super(initialState) {
    getAppVersion();
    initSharedPreferences();
    // getPetData();
    // getPetBreed();
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
    } else {
      _petDetail.age = -1;
    }
    add(PetProfileEvent.PET_DETAILS_CHANGED);
  }

  void petAggressionChanged(Aggression aggression) {
    _petDetail.aggression = aggression;
    add(PetProfileEvent.PET_DETAILS_CHANGED);
  }

  void petWeightChanged(String weight) {
    if (double.tryParse(weight) != null) {
      _petDetail.weight = double.parse(weight);
    } else {
      _petDetail.weight = -1;
    }
    add(PetProfileEvent.PET_DETAILS_CHANGED);
  }

  void petVaccinationCountChanged(int vaccinationCount) {
    _petDetail.vaccine = vaccinationCount;
    add(PetProfileEvent.PET_DETAILS_CHANGED);
  }

  void petBreedChanged(BreedDetail? breed) {
    _petDetail.subCategory = breed;
    add(PetProfileEvent.PET_DETAILS_CHANGED);
  }

  void petCategoryChanged(PetCategory category) {
    _petDetail.petCategory = category;
    _petDetail.subCategory = null;
    add(PetProfileEvent.PET_DETAILS_CHANGED);
  }

  void setId(id) {
    _id = id;
    _petDetail = PetDetailForUpload.fromPetStore(
        _petList.petDataStore.firstWhere((element) => element.id == id));
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

  void getSinglePetData(String petId) async {
    add(PetProfileEvent.FETCHING_PET_DETAIL);
    var response =
          await ApiCaller.get(kUrlGetSinglePetData(petId), withToken: true);
    PetCURLModel petData = PetCURLModel.fromJson(response);
    _petDetail = PetDetailForUpload.fromPetStore(petData.data!.customerPet!);
    add(PetProfileEvent.PET_DETAILS_LOADED);
  }

  void initAddPet() {
    add(PetProfileEvent.INIT_ADD_PET);
  }

  void selectPetImage(String petId) async {
    final ImagePicker _picker = ImagePicker();
    _image = await _picker.pickImage(source: ImageSource.gallery);
    Map<String, dynamic> image = Map();
    Uint8List imageByte = await _image!.readAsBytes();
    image["base64_string"] =
        'data:image/jpeg;base64,${base64Encode(imageByte)}';
    Map<String, dynamic> customerPet = Map();
    customerPet["image"] = image;
    Map<String, dynamic> data = Map();
    data["customer_pet"] = customerPet;
   
    await ApiCaller.post(kUrlUploadPetImage(petId), data, withToken: true);
    add(PetProfileEvent.IMAGE_SELECTED);
  }
 

  void updatePetData(String petId) async {
    bool _error = false;
    RequestPetData data = RequestPetData.from(_petDetail);
    add(PetProfileEvent.RESET_ALL_WARNINGS);
    if (data.name == null || data.name!.length == 0) {
      _error = true;
      add(PetProfileEvent.ERROR_PET_NAME_MISSING);
    }
    if (data.categoryId == null) {
      _error = true;
      add(PetProfileEvent.ERROR_CATEGORY_NOT_SELECTED);
    }
    if (data.subCategoryId == null) {
      _error = true;
      add(PetProfileEvent.ERROR_BREED_NOT_SELECTED);
    }
    if (data.age == null || data.age == -1) {
      _error = true;
      add(PetProfileEvent.ERROR_AGE_MISSING);
    }
    if (data.weight == null || data.weight == -1) {
      _error = true;
      add(PetProfileEvent.ERROR_WEIGHT_MISSING);
    }
    if (!_error) {
      add(PetProfileEvent.UPDATING_PET_DETAIL);
      // add(PetProfileEvent.PET_UPDATED);
      var value =
          await ApiCaller.put('${kUrlUpdatePet(petId)}', data, withToken: true);
      PetCURLModel petCreatedResponse = PetCURLModel.fromJson(value);
      if (petCreatedResponse.data != null) {
        _petList.petDataStore.removeWhere((element) => element.id == _id);
        _petList.addToList(petCreatedResponse);
        add(PetProfileEvent.PET_UPDATED);
      } else
        add(PetProfileEvent.ERROR_RESPONSE);
    }
  }

  void createNewPet({bool fromPopup = false}) async {
    bool _error = false;
    RequestPetData data = RequestPetData.from(_petDetail);
    add(PetProfileEvent.RESET_ALL_WARNINGS);
    if (data.name == null || data.name!.length == 0) {
      _error = true;
      add(PetProfileEvent.ERROR_PET_NAME_MISSING);
    }
    if (data.categoryId == null) {
      _error = true;
      add(PetProfileEvent.ERROR_CATEGORY_NOT_SELECTED);
    }
    if (data.subCategoryId == null) {
      _error = true;
      add(PetProfileEvent.ERROR_BREED_NOT_SELECTED);
    }
    if (data.age == null || data.age == -1) {
      _error = true;
      add(PetProfileEvent.ERROR_AGE_MISSING);
    }
    if (data.weight == null || data.weight == -1) {
      _error = true;
      add(PetProfileEvent.ERROR_WEIGHT_MISSING);
    }
    if (!_error) {
      add(PetProfileEvent.ADDING_PET);

      var value =
          await ApiCaller.post(kUrlCreatePet, data.toJson(), withToken: true);
      PetCURLModel petCreatedResponse = PetCURLModel.fromJson(value);
      if (petCreatedResponse.data != null) {
        _petList.addToList(petCreatedResponse);
        add(PetProfileEvent.PET_ADDED);
        if (fromPopup) add(PetProfileEvent.SHOW_ADDED_PET_POPUP);
      } else
        add(PetProfileEvent.ERROR_RESPONSE);
    }
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
    } else if (event == PetProfileEvent.ADDING_PET) {
      yield state.copyWith(addingPet: true);
    } else if (event == PetProfileEvent.PET_ADDED) {
      yield state.copyWith(
          petCreated: true, addingPet: false, petList: _petList);
    } else if (event == PetProfileEvent.ERROR_RESPONSE) {
      yield state.copyWith(error: true, addingPet: false);
    } else if (event == PetProfileEvent.PET_DETAILS_LOADED) {
      yield state.copyWith(
          petList: _petList, fetchingPetData: false, addUpdatePet: _petDetail);
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
    } else if (event == PetProfileEvent.FETCHING_PET_DETAIL) {
      yield state.copyWith(fetchingPetData: true);
    } else if (event == PetProfileEvent.INIT_ADD_PET) {
      yield state.copyWith(addUpdatePet: PetDetailForUpload());
    } else if (event == PetProfileEvent.RESET_ALL_WARNINGS) {
      yield state.copyWith(
          errorNameIsMissing: false,
          errorAgeIsMissing: false,
          errorBreedIsMissing: false,
          errorCategoryIsMissing: false,
          errorWeightIsMissing: false);
    } else if (event == PetProfileEvent.ERROR_PET_NAME_MISSING) {
      yield state.copyWith(errorNameIsMissing: true);
    } else if (event == PetProfileEvent.ERROR_AGE_MISSING) {
      yield state.copyWith(errorAgeIsMissing: true);
    } else if (event == PetProfileEvent.ERROR_WEIGHT_MISSING) {
      yield state.copyWith(errorWeightIsMissing: true);
    } else if (event == PetProfileEvent.ERROR_CATEGORY_NOT_SELECTED) {
      yield state.copyWith(errorCategoryIsMissing: true);
    } else if (event == PetProfileEvent.ERROR_BREED_NOT_SELECTED) {
      yield state.copyWith(errorBreedIsMissing: true);
    } else if (event == PetProfileEvent.IMAGE_SELECTED) {
      yield state.copyWith(image: _image);
    }
  }
}
