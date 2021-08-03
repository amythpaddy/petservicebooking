import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:the_pet_nest/addressBook/model/StatesAndCityModel.dart';
import 'package:the_pet_nest/addressBook/model/addAddressModel.dart';
import 'package:the_pet_nest/addressBook/model/addressListModel.dart';

class AddressBookState {
  AddressListResponse? savedAddresses;
  String? errorMessage;
  bool locationError;
  bool locationUpdated;
  Marker? mapMarker;
  bool showAddressModal;
  double modalHeight;
  double bottomSheetHeight;
  int blackScreenAlpha;
  bool showCollapsedUi;
  AddAddressModel? addAddressModel;
  StatesAndCitiesResponse? statesAndCitiesList;
  bool addingNewAddress;
  bool addressBookUpdated;

  AddressBookState(
      {this.savedAddresses,
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
      this.addingNewAddress = false,
      this.addressBookUpdated = false}) {
    savedAddresses = this.savedAddresses ?? AddressListResponse();
    addAddressModel = this.addAddressModel ?? AddAddressModel();
    statesAndCitiesList = this.statesAndCitiesList ?? StatesAndCitiesResponse();
  }

  AddressBookState copyWith(
      {AddressListResponse? savedAddresses,
      String? errorMessage,
      bool? locationError,
      bool? locationUpdated,
      Marker? mapMarker,
      double? modalHeight,
      double? bottomSheetHeight,
      int? blackScreenAlpha,
      bool? showCollapsedUi,
      AddAddressModel? addAddressModel,
      StatesAndCitiesResponse? statesAndCitiesList,
      bool? addingNewAddress,
      bool? addressBookUpdated}) {
    return AddressBookState(
        savedAddresses: savedAddresses ?? this.savedAddresses,
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
        addingNewAddress: addingNewAddress ?? false,
        addressBookUpdated: addressBookUpdated ?? false);
  }
}
