import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:the_pet_nest/addressBook/bloc/addressBookEvent.dart';
import 'package:the_pet_nest/addressBook/bloc/addressBookState.dart';
import 'package:the_pet_nest/addressBook/model/StatesAndCityModel.dart';
import 'package:the_pet_nest/addressBook/model/addAddressModel.dart';
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
  AddAddressModel _addAddressModel = AddAddressModel();
  late StatesAndCitiesResponse _statesAndCitiesResponse;

  AddressBookBloc(
      {required AddressBookState initialState, BuildContext? context})
      : super(initialState) {
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
    add(AddressBookEvent.STATES_N_CITIES_LIST_FETCHED);
  }

  void addNewAddress() async {
    print('adding new address');
    add(AddressBookEvent.ADDING_NEW_ADDRESS);
    var response = await ApiCaller.post(
        kUrlAddSavedAddresses, _addAddressModel.toJson(),
        withToken: true);
    print(response);
    add(AddressBookEvent.ADDRESS_BOOK_UPDATED);
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
      yield state.copyWith(statesAndCitiesList: _statesAndCitiesResponse);
    } else if (event == AddressBookEvent.ADDING_NEW_ADDRESS) {
      yield state.copyWith(addingNewAddress: true);
    } else if (event == AddressBookEvent.ADDRESS_BOOK_UPDATED) {
      yield state.copyWith(addressBookUpdated: true);
    }
  }
}
