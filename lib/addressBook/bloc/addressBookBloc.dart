import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:the_pet_nest/addressBook/bloc/addressBookEvent.dart';
import 'package:the_pet_nest/addressBook/bloc/addressBookState.dart';
import 'package:the_pet_nest/addressBook/model/addAddressRequestModel.dart';
import 'package:the_pet_nest/addressBook/model/addAddressResponseModel.dart';
import 'package:the_pet_nest/addressBook/model/addressBookModel.dart';
import 'package:the_pet_nest/addressBook/model/savedAddressesAPIModel.dart';
import 'package:the_pet_nest/addressBook/model/statesAndCityApiModel.dart';
import 'package:the_pet_nest/konstants/endpoints.dart';
import 'package:the_pet_nest/konstants/enums.dart';
import 'package:the_pet_nest/utils/ApiCaller.dart';

class AddressBookBloc extends Bloc<AddressBookEvent, AddressBookState> {
  String _errorMessage = "";
  late Marker _marker;
  BuildContext? _mContext;
  // ignore: non_constant_identifier_names
  final double _MIN_BOTTOM_SHEET_HEIGHT = 232;
  // ignore: non_constant_identifier_names
  final double _MAX_BOTTOM_SHEET_HEIGHT = 598;
  final double _alphaFactor = 0.4098;
  double _currentBottomSheetHeight = 232;
  int _blackScreenAlpha = 0;
  bool _showCollapsedUI = true;
  AddAddressRequestModel _addAddressModel = AddAddressRequestModel();
  late StatesAndCitiesResponse _statesAndCitiesResponse;
  late AddressBookModel _addressBook = AddressBookModel();
  late CityList _cityList;
  late CityDetail _selectedCity;
  int _addressSelectedIndex = -1;

  AddressBookBloc(
      {required AddressBookState initialState, BuildContext? context})
      : super(initialState) {
    getSavedAddress();
    getCurrentPosition();
    getCityAndState();
    if (context != null) {
      this._mContext = context;
      loadMapMarker(context);
    }
  }

  void loadMapMarker(BuildContext context) {
    ImageConfiguration configuration = createLocalImageConfiguration(context);
    BitmapDescriptor.fromAssetImage(
            configuration, 'assets/images/map/map_pin.png')
        .then((icon) {
      _marker = Marker(
          markerId: MarkerId("marker1"),
          // anchor: Offset(0, 0),
          position: _addAddressModel.mapPosition!.target,
          draggable: true,
          icon: icon);
      add(AddressBookEvent.MAP_MARKER_UPDATED);
    });
  }

  void getCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _errorMessage = "Location Service is disabled";
      add(AddressBookEvent.LOCATION_ERROR);
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _errorMessage = "Location Permission denied";
        add(AddressBookEvent.LOCATION_ERROR);
      }
    } else if (permission == LocationPermission.deniedForever) {
      _errorMessage =
          "Please enable location permission from settings to enable this.";
      add(AddressBookEvent.LOCATION_ERROR);
    }
    Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    _addAddressModel.mapPosition = CameraPosition(
      target: LatLng(currentPosition.latitude, currentPosition.longitude),
      zoom: 14.4746,
    );
    if (_mContext != null) loadMapMarker(_mContext!);
    add(AddressBookEvent.MAP_POS_UPDATED);
  }

  updateCurrentPosition(CameraPosition cameraPosition) {
    _addAddressModel.mapPosition = cameraPosition;
    if (_mContext != null)
      _marker = _marker.copyWith(positionParam: cameraPosition.target);
    add(AddressBookEvent.MAP_MARKER_UPDATED);
  }

  void bottomSheetScrolled(double dy) {
    double tempHeight = _currentBottomSheetHeight - dy;
    if (_MAX_BOTTOM_SHEET_HEIGHT >= tempHeight &&
        tempHeight >= _MIN_BOTTOM_SHEET_HEIGHT) {
      _currentBottomSheetHeight = tempHeight;
      _blackScreenAlpha =
          ((_currentBottomSheetHeight - _MIN_BOTTOM_SHEET_HEIGHT) *
                  _alphaFactor)
              .truncate();
      _showCollapsedUI =
          (_currentBottomSheetHeight < _MAX_BOTTOM_SHEET_HEIGHT - 30);
      add(AddressBookEvent.BOTTOM_SHEET_SWIPE);
    }
  }

  void bottomSheetScrollStopped() {
    if (_currentBottomSheetHeight > (_MAX_BOTTOM_SHEET_HEIGHT / 2)) {
      _currentBottomSheetHeight = _MAX_BOTTOM_SHEET_HEIGHT;
      _blackScreenAlpha = 150;
    } else {
      _currentBottomSheetHeight = _MIN_BOTTOM_SHEET_HEIGHT;
      _blackScreenAlpha = 0;
    }
    _showCollapsedUI =
        (_currentBottomSheetHeight < _MAX_BOTTOM_SHEET_HEIGHT - 30);
    add(AddressBookEvent.BOTTOM_SHEET_SWIPE);
  }

  void expandBottomSheet() {
    _currentBottomSheetHeight = _MAX_BOTTOM_SHEET_HEIGHT;
    _showCollapsedUI = false;
    _blackScreenAlpha = 150;
    add(AddressBookEvent.BOTTOM_SHEET_SWIPE);
  }

  void updateAddress({
    AddressType? addressType,
    String? addressLineOne,
    String? addressLineTwo,
    int? cityId,
    String? city,
    int? stateId,
    String? state,
    int? zipCode,
  }) {
    _addAddressModel = _addAddressModel.update(
        addressLineOne: addressLineOne,
        addressLineTwo: addressLineTwo,
        city: city,
        cityId: cityId,
        state: state,
        stateId: stateId,
        zipCode: zipCode,
        addressType: addressType);
    add(AddressBookEvent.ADDRESS_FIELDS_UPDATED);
  }

  void getCityAndState() async {
    var response = await ApiCaller.get(kUrlGetStatesAndCities);
    _statesAndCitiesResponse = StatesAndCitiesResponse.fromJson(response);
    _cityList = CityList();
    _cityList.createCityListFromCityStateList(_statesAndCitiesResponse);
    add(AddressBookEvent.STATES_N_CITIES_LIST_FETCHED);
  }

  void getSavedAddress() async {
    add(AddressBookEvent.FETCHING_ADDRESS_BOOK);
    var response = await ApiCaller.get(kUrlGetSavedAddresses, withToken: true);
    _addressBook.addAddressFromSavedAddressList(
        SavedAddressResponse.fromJson(response));
    add(AddressBookEvent.ADDRESS_BOOK_UPDATED);
  }

  void addNewAddress() async {
    add(AddressBookEvent.ADDING_NEW_ADDRESS);
    var response = await ApiCaller.post(
        kUrlAddSavedAddresses, _addAddressModel.toJson(),
        withToken: true);
    _addressBook.addAddressFromAddedAddressResponse(
        AddEditAddressResponse.fromJson(response));
    add(AddressBookEvent.NEW_ADDRESS_ADDED);
  }

  void filterAddress(CityDetail cityDetail) async {
    _selectedCity = cityDetail;
    add(AddressBookEvent.CITY_SELECTED_FROM_DROPDOWN);
    add(AddressBookEvent.FETCHING_ADDRESS_BOOK);
    var response = await ApiCaller.get(
        '$kUrlGetSavedAddresses?city_id=${cityDetail.cityId}',
        withToken: true);
    _addressBook.addAddressFromSavedAddressList(
        SavedAddressResponse.fromJson(response));
    add(AddressBookEvent.ADDRESS_BOOK_UPDATED);
  }

  void addressSelectedByUser(int index) {
    _addressSelectedIndex = index;
    add(AddressBookEvent.ADDRESS_SELECTED_FROM_LIST);
  }

  @override
  Stream<AddressBookState> mapEventToState(AddressBookEvent event) async* {
    if (event == AddressBookEvent.LOCATION_ERROR) {
      yield state.copyWith(locationError: true, errorMessage: _errorMessage);
    } else if (event == AddressBookEvent.MAP_POS_UPDATED) {
      yield state.copyWith(
          locationError: false,
          addAddressModel: _addAddressModel,
          locationUpdated: true);
    } else if (event == AddressBookEvent.MAP_MARKER_UPDATED) {
      yield state.copyWith(
        mapMarker: _marker,
        addAddressModel: _addAddressModel,
      );
    } else if (event == AddressBookEvent.BOTTOM_SHEET_SWIPE) {
      yield state.copyWith(
          bottomSheetHeight: _currentBottomSheetHeight,
          blackScreenAlpha: _blackScreenAlpha,
          showCollapsedUi: _showCollapsedUI);
    } else if (event == AddressBookEvent.ADDRESS_FIELDS_UPDATED) {
      yield state.copyWith(addAddressModel: _addAddressModel);
    } else if (event == AddressBookEvent.STATES_N_CITIES_LIST_FETCHED) {
      yield state.copyWith(
          statesAndCitiesList: _statesAndCitiesResponse, cityList: _cityList);
    } else if (event == AddressBookEvent.ADDING_NEW_ADDRESS) {
      yield state.copyWith(addingNewAddress: true);
    } else if (event == AddressBookEvent.ADDRESS_BOOK_UPDATED) {
      yield state.copyWith(
          addressBookUpdated: true,
          addingNewAddress: false,
          fetchingAddressBook: false,
          addressBook: _addressBook);
    } else if (event == AddressBookEvent.NEW_ADDRESS_ADDED) {
      state.copyWith(
          addressAdded: true,
          addingNewAddress: false,
          fetchingAddressBook: false,
          addressBook: _addressBook);
    } else if (event == AddressBookEvent.FETCHING_ADDRESS_BOOK) {
      yield state.copyWith(fetchingAddressBook: true);
    } else if (event == AddressBookEvent.OPEN_ADD_EDIT_ADDRESS_SCREEN) {
      yield state.copyWith(
          openAddEditAddressScreen: true,
          addressBookUpdated: false,
          addressAdded: false);
    } else if (event == AddressBookEvent.CITY_SELECTED_FROM_DROPDOWN) {
      yield state.copyWith(selectedCity: _selectedCity);
    } else if (event == AddressBookEvent.ADDRESS_SELECTED_FROM_LIST) {
      yield state.copyWith(selectedAddressIndex: _addressSelectedIndex);
    }
  }

  void openAddAddress() {
    add(AddressBookEvent.OPEN_ADD_EDIT_ADDRESS_SCREEN);
  }
}
