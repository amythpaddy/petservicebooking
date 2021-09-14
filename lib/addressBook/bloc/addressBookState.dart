import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:the_pet_nest/addressBook/model/addAddressRequestModel.dart';
import 'package:the_pet_nest/addressBook/model/addressBookModel.dart';
import 'package:the_pet_nest/addressBook/model/statesAndCityApiModel.dart';

class AddressBookState extends Equatable {
  final Marker? mapMarker;
  final AddAddressRequestModel? addAddressModel;
  final StatesAndCitiesResponse? statesAndCitiesList;
  final AddressBookModel? addressBook;
  final CityList? cityList;
  final CityDetail? selectedCity;
  final String? errorMessage;
  final bool locationError;
  final bool locationUpdated;
  final bool showAddressModal;
  final double modalHeight;
  final double bottomSheetHeight;
  final int blackScreenAlpha;
  final bool showCollapsedUi;
  final bool fetchingAddressBook;
  final bool savingAddress;
  final bool addressBookUpdated;
  final bool openAddEditAddressScreen;
  final bool addressAdded;
  final int filterCityId;
  final int selectedAddressIndex;
  final bool addressLineOneMissing;
  final bool addressStateMissing;
  final bool addressLineTwoMissing;
  final bool addressCityMissing;
  final bool addressZipcodeMissing;
  final bool editingSavedAddress;
  final bool savedAddressUpdated;

  AddressBookState({
    this.errorMessage,
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
    this.savingAddress = false,
    this.addressBookUpdated = false,
    this.fetchingAddressBook = false,
    this.addressBook,
    this.openAddEditAddressScreen = false,
    this.addressAdded = false,
    this.filterCityId = -1,
    this.cityList,
    this.selectedCity,
    this.selectedAddressIndex = -1,
    this.addressLineOneMissing = false,
    this.addressStateMissing = false,
    this.addressLineTwoMissing = false,
    this.addressCityMissing = false,
    this.addressZipcodeMissing = false,
    this.editingSavedAddress = false,
    this.savedAddressUpdated = false,
  });

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
    bool? savingAddress,
    bool? addressBookUpdated,
    bool? fetchingAddressBook,
    bool? openAddEditAddressScreen,
    bool? addressAdded,
    int? filterCityId,
    CityList? cityList,
    CityDetail? selectedCity,
    int? selectedAddressIndex,
    bool? addressLineOneMissing,
    bool? addressStateMissing,
    bool? addressLineTwoMissing,
    bool? addressCityMissing,
    bool? addressZipcodeMissing,
    bool? editingSavedAddress,
    bool? savedAddressUpdated,
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
        addAddressModel: addAddressModel ?? this.addAddressModel,
        statesAndCitiesList: statesAndCitiesList ?? this.statesAndCitiesList,
        savingAddress: savingAddress ?? this.savingAddress,
        addressBookUpdated: addressBookUpdated ?? false,
        fetchingAddressBook: fetchingAddressBook ?? this.fetchingAddressBook,
        openAddEditAddressScreen: openAddEditAddressScreen ?? false,
        addressAdded: addressAdded ?? false,
        filterCityId: filterCityId ?? this.filterCityId,
        cityList: cityList ?? this.cityList,
        selectedCity: selectedCity ?? this.selectedCity,
        selectedAddressIndex: selectedAddressIndex ?? this.selectedAddressIndex,
        addressLineOneMissing:
            addressLineOneMissing ?? this.addressLineOneMissing,
        addressLineTwoMissing:
            addressLineTwoMissing ?? this.addressLineTwoMissing,
        addressCityMissing: addressCityMissing ?? this.addressCityMissing,
        addressStateMissing: addressStateMissing ?? this.addressStateMissing,
        addressZipcodeMissing:
            addressZipcodeMissing ?? this.addressZipcodeMissing,
        editingSavedAddress: editingSavedAddress ?? this.editingSavedAddress,
        savedAddressUpdated: savedAddressUpdated ?? this.savedAddressUpdated);
  }

  @override
  List<Object?> get props => [
        errorMessage,
        locationError,
        locationUpdated,
        mapMarker,
        showAddressModal,
        modalHeight,
        bottomSheetHeight,
        blackScreenAlpha,
        showCollapsedUi,
        addAddressModel,
        statesAndCitiesList,
        savingAddress,
        addressBookUpdated,
        fetchingAddressBook,
        addressBook,
        openAddEditAddressScreen,
        addressAdded,
        filterCityId,
        cityList,
        selectedCity,
        selectedAddressIndex,
        addressLineOneMissing,
        addressStateMissing,
        addressLineTwoMissing,
        addressCityMissing,
        addressZipcodeMissing,
        editingSavedAddress,
        savedAddressUpdated
      ];
}
