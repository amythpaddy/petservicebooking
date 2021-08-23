import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:the_pet_nest/addressBook/model/addAddressRequestModel.dart';
import 'package:the_pet_nest/addressBook/model/addressBookModel.dart';
import 'package:the_pet_nest/addressBook/model/statesAndCityApiModel.dart';

class AddressBookState {
  Marker? mapMarker;
  AddAddressRequestModel? addAddressModel;
  StatesAndCitiesResponse? statesAndCitiesList;
  AddressBookModel? addressBook;
  CityList? cityList;
  CityDetail? selectedCity;
  String? errorMessage;
  bool locationError;
  bool locationUpdated;
  bool showAddressModal;
  double modalHeight;
  double bottomSheetHeight;
  int blackScreenAlpha;
  bool showCollapsedUi;
  bool fetchingAddressBook;
  bool addingNewAddress;
  bool addressBookUpdated;
  bool openAddEditAddressScreen;
  bool addressAdded;
  int filterCityId;
  int selectedAddressIndex;

  AddressBookState(
      {this.errorMessage,
      this.locationError = false,
      this.locationUpdated = false,
      this.mapMarker,
      this.showAddressModal = true,
      this.modalHeight = 0.23,
      this.bottomSheetHeight = 232,
      this.blackScreenAlpha = 0,
      this.showCollapsedUi = true,
      this.addAddressModel,
      this.statesAndCitiesList,
      this.addingNewAddress = false,
      this.addressBookUpdated = false,
      this.fetchingAddressBook = false,
      this.addressBook,
      this.openAddEditAddressScreen = false,
      this.addressAdded = false,
      this.filterCityId = -1,
      this.cityList,
      this.selectedCity,
      this.selectedAddressIndex = -1}) {
    addAddressModel = this.addAddressModel ?? AddAddressRequestModel();
    statesAndCitiesList = this.statesAndCitiesList ?? StatesAndCitiesResponse();
    addressBook = this.addressBook ?? AddressBookModel();
    cityList = this.cityList;
  }

  AddressBookState copyWith({
    AddressBookModel? addressBook,
    String? errorMessage,
    bool? locationError,
    bool? locationUpdated,
    Marker? mapMarker,
    double? modalHeight,
    double? bottomSheetHeight,
    int? blackScreenAlpha,
    bool? showCollapsedUi,
    AddAddressRequestModel? addAddressModel,
    StatesAndCitiesResponse? statesAndCitiesList,
    bool? addingNewAddress,
    bool? addressBookUpdated,
    bool? fetchingAddressBook,
    bool? openAddEditAddressScreen,
    bool? addressAdded,
    int? filterCityId,
    CityList? cityList,
    CityDetail? selectedCity,
    int? selectedAddressIndex,
  }) {
    return AddressBookState(
        addressBook: addressBook ?? this.addressBook,
        errorMessage: errorMessage ?? this.errorMessage,
        locationError: locationError ?? false,
        locationUpdated: locationUpdated ?? false,
        modalHeight: modalHeight ?? this.modalHeight,
        mapMarker: mapMarker ?? this.mapMarker,
        bottomSheetHeight: bottomSheetHeight ?? this.bottomSheetHeight,
        blackScreenAlpha: blackScreenAlpha ?? this.blackScreenAlpha,
        showCollapsedUi: showCollapsedUi ?? this.showCollapsedUi,
        addAddressModel: addAddressModel,
        statesAndCitiesList: statesAndCitiesList ?? this.statesAndCitiesList,
        addingNewAddress: addingNewAddress ?? this.addingNewAddress,
        addressBookUpdated: addressBookUpdated ?? false,
        fetchingAddressBook: fetchingAddressBook ?? this.fetchingAddressBook,
        openAddEditAddressScreen: openAddEditAddressScreen ?? false,
        addressAdded: addressAdded ?? false,
        filterCityId: filterCityId ?? this.filterCityId,
        cityList: cityList ?? this.cityList,
        selectedCity: selectedCity ?? this.selectedCity,
        selectedAddressIndex:
            selectedAddressIndex ?? this.selectedAddressIndex);
  }
}
