import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:the_pet_nest/addressBook/bloc/addressBookBloc.dart';
import 'package:the_pet_nest/addressBook/bloc/addressBookState.dart';
import 'package:the_pet_nest/addressBook/model/addressBookModel.dart';
import 'package:the_pet_nest/addressBook/model/statesAndCityApiModel.dart';
import 'package:the_pet_nest/config/sizeConfig.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/enums.dart';
import 'package:the_pet_nest/konstants/styles.dart';
import 'package:the_pet_nest/profiles/petProfile/component/heading.dart';
import 'package:the_pet_nest/profiles/userProfile/component/userDetailInput.dart';

class AddEditMap extends StatelessWidget {
  late final String? _mapStyle;

  AddEditMap({Key? key}) : super(key: key) {
    rootBundle.loadString('assets/map_style/style.txt').then((string) {
      _mapStyle = string;
    });
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(22.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    Address? address = ModalRoute.of(context)!.settings.arguments as Address?;
    SizeConfig().init(context);
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocProvider(
          create: (_) => AddressBookBloc(
              initialState: AddressBookState(),
              context: context,
              editAddress: address),
          child: BlocListener<AddressBookBloc, AddressBookState>(
            listener: (blocContext, state) {
              if (state.locationUpdated) {
                updateLocationOnMap(state.addAddressModel!.mapPosition!);
              }
              if (state.addressAdded || state.savedAddressUpdated) {
                Navigator.pop(blocContext);
              }
            },
            child: BlocBuilder<AddressBookBloc, AddressBookState>(
              builder: (blocContext, state) {
                if (state.addAddressModel == null) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: kAppIconColor,
                    ),
                  );
                } else {
                  return Stack(
                    children: [
                      GoogleMap(
                        mapType: MapType.terrain,
                        markers: state.mapMarker == null
                            ? const <Marker>{}
                            : [state.mapMarker!].toSet(),
                        initialCameraPosition:
                            CameraPosition(target: LatLng(28.7041, 77.1025)),
                        onMapCreated: (GoogleMapController controller) {
                          controller.setMapStyle(_mapStyle);
                          _controller.complete(controller);
                        },
                        onCameraMoveStarted: () => {},
                        onCameraMove: (cameraPosition) =>
                            BlocProvider.of<AddressBookBloc>(blocContext)
                                .updateCurrentPosition(cameraPosition),
                      ),
                      Visibility(
                        visible: !state.showCollapsedUi,
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          color:
                              Color.fromARGB(state.blackScreenAlpha, 0, 0, 0),
                        ),
                      ),
                      Positioned(
                          bottom: 240,
                          left: SizeConfig.blockSizeHorizontal * 42,
                          child: TextButton(
                            onPressed: () =>
                                BlocProvider.of<AddressBookBloc>(blocContext)
                                    .expandBottomSheet(),
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                color: kAppIconColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                              ),
                              child: Icon(
                                Icons.keyboard_arrow_up,
                                color: Colors.white,
                              ),
                            ),
                          )),
                      Positioned(
                        bottom: 0,
                        child: GestureDetector(
                          onVerticalDragEnd: (dragEndDetail) =>
                              BlocProvider.of<AddressBookBloc>(blocContext)
                                  .bottomSheetScrollStopped(),
                          onVerticalDragUpdate: (dragDetail) =>
                              BlocProvider.of<AddressBookBloc>(blocContext)
                                  .bottomSheetScrolled(
                                      dragDetail.primaryDelta ?? 0),
                          child: SingleChildScrollView(
                            child: Container(
                              alignment: Alignment.center,
                              height: state.bottomSheetHeight,
                              width: (SizeConfig.blockSizeHorizontal * 100),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10))),
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    state.showCollapsedUi
                                        ? Text(
                                            'Swipe Up',
                                            style: TextStyle(
                                                fontSize: 10,
                                                height: 1.5,
                                                fontWeight: FontWeight.w300,
                                                color: kAppIconColor),
                                          )
                                        : Container(
                                            height: 2,
                                            width: 38.34,
                                            decoration: BoxDecoration(
                                                color: kAppIconColor,
                                                borderRadius:
                                                    BorderRadius.circular(1)),
                                          ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    UserDetailInput(
                                      heading: 'Address 1',
                                      onDataFilled: (data) => BlocProvider.of<
                                              AddressBookBloc>(blocContext)
                                          .updateAddress(addressLineOne: data),
                                      value: state.addAddressModel == null
                                          ? ""
                                          : state
                                              .addAddressModel!.addressLineOne,
                                      showError: state.addressLineOneMissing,
                                    ),
                                    state.showCollapsedUi
                                        ? Expanded(child: Container())
                                        : Column(
                                            children: [
                                              UserDetailInput(
                                                heading:
                                                    'House / Flat / Block No.',
                                                onDataFilled: (data) =>
                                                    BlocProvider.of<
                                                                AddressBookBloc>(
                                                            blocContext)
                                                        .updateAddress(
                                                            addressLineTwo:
                                                                data),
                                                value: state.addAddressModel ==
                                                        null
                                                    ? ""
                                                    : state.addAddressModel!
                                                        .addressLineTwo,
                                                required: false,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        Heading(
                                                            heading: 'State',
                                                            required: false),
                                                        SizedBox(
                                                          height: 6.2,
                                                        ),
                                                        (state.statesAndCitiesList ==
                                                                    null ||
                                                                state.statesAndCitiesList!
                                                                        .stateList ==
                                                                    null)
                                                            ? CircularProgressIndicator()
                                                            : Container(
                                                                height: 40,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                    border: Border.all(
                                                                        color: state.addressStateMissing
                                                                            ? Colors.redAccent
                                                                            : Colors.transparent)),
                                                                child: DropdownSearch<
                                                                    StateData>(
                                                                  dropdownBuilder:
                                                                      (context,
                                                                          data,
                                                                          value) {
                                                                    return Text(
                                                                      value,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    );
                                                                  },
                                                                  dropdownSearchDecoration:
                                                                      InputDecoration(
                                                                          contentPadding: EdgeInsets.fromLTRB(
                                                                              12,
                                                                              2,
                                                                              0,
                                                                              0),
                                                                          border:
                                                                              OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(color: Color(0x331A202E)),
                                                                            borderRadius:
                                                                                BorderRadius.circular(12),
                                                                          )),
                                                                  mode: Mode
                                                                      .BOTTOM_SHEET,
                                                                  showSelectedItem:
                                                                      true,
                                                                  selectedItem: getSelectedState(
                                                                      state
                                                                          .addAddressModel!
                                                                          .stateId,
                                                                      state
                                                                          .statesAndCitiesList!
                                                                          .stateList),
                                                                  showSearchBox:
                                                                      true,
                                                                  items: state
                                                                      .statesAndCitiesList!
                                                                      .stateList!,
                                                                  itemAsString:
                                                                      (item) =>
                                                                          item.name!,
                                                                  compareFn:
                                                                      (i, s) =>
                                                                          true,
                                                                  hint:
                                                                      "Choose State",
                                                                  emptyBuilder:
                                                                      (context,
                                                                          data) {
                                                                    return Center(
                                                                      child:
                                                                          Text(
                                                                        'No State Found',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                    );
                                                                  },
                                                                  onChanged: (value) => BlocProvider.of<
                                                                              AddressBookBloc>(
                                                                          blocContext)
                                                                      .updateAddress(
                                                                          state: value!
                                                                              .name,
                                                                          stateId:
                                                                              value.id),
                                                                ),
                                                              ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 25,
                                                  ),
                                                  Expanded(
                                                      child: UserDetailInput(
                                                    heading: 'ZIP Code',
                                                    onDataFilled: (data) =>
                                                        BlocProvider.of<
                                                                    AddressBookBloc>(
                                                                blocContext)
                                                            .updateAddress(
                                                                zipCode: data),
                                                    value: state
                                                        .addAddressModel!
                                                        .zipCode
                                                        .toString(),
                                                    required: false,
                                                    showError: state
                                                        .addressZipcodeMissing,
                                                  ))
                                                ],
                                              ),
                                              Heading(
                                                  heading: 'City',
                                                  required: false),
                                              SizedBox(
                                                height: 6.2,
                                              ),
                                              (state.statesAndCitiesList ==
                                                          null ||
                                                      state.statesAndCitiesList!
                                                              .stateList ==
                                                          null)
                                                  ? CircularProgressIndicator()
                                                  : Container(
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          border: Border.all(
                                                              color: state
                                                                      .addressCityMissing
                                                                  ? Colors
                                                                      .redAccent
                                                                  : Colors
                                                                      .transparent)),
                                                      child: DropdownSearch<
                                                          Cities>(
                                                        dropdownSearchDecoration:
                                                            InputDecoration(
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            12,
                                                                            2,
                                                                            0,
                                                                            0),
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              Color(0x331A202E)),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                )),
                                                        mode: Mode.BOTTOM_SHEET,
                                                        showSearchBox: true,
                                                        selectedItem: getSelectedCity(
                                                            state
                                                                .addAddressModel!
                                                                .cityId,
                                                            state.addAddressModel!
                                                                        .stateId ==
                                                                    -1
                                                                ? []
                                                                : state
                                                                    .statesAndCitiesList!
                                                                    .stateList![
                                                                        state.addAddressModel!.stateId -
                                                                            1]
                                                                    .cities),
                                                        showSelectedItem: true,
                                                        items: state.addAddressModel!
                                                                    .stateId ==
                                                                -1
                                                            ? []
                                                            : state
                                                                .statesAndCitiesList!
                                                                .stateList![state
                                                                        .addAddressModel!
                                                                        .stateId -
                                                                    1]
                                                                .cities!,
                                                        itemAsString:
                                                            (cities) =>
                                                                cities.cityName,
                                                        hint: "Choose City",
                                                        emptyBuilder:
                                                            (context, data) {
                                                          return Center(
                                                            child: Text(
                                                              'No City Found',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 12),
                                                            ),
                                                          );
                                                        },
                                                        onChanged: (value) =>
                                                            BlocProvider.of<
                                                                        AddressBookBloc>(
                                                                    blocContext)
                                                                .updateAddress(
                                                                    city: value!
                                                                        .cityName,
                                                                    cityId: value
                                                                        .id),
                                                        compareFn: (i, s) =>
                                                            true,
                                                      ),
                                                    ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          'assets/images/funnels/icon_home.svg'),
                                                      Text('Home'),
                                                      SizedBox(
                                                        width: 26,
                                                        child:
                                                            Radio<AddressType>(
                                                          activeColor:
                                                              kTextColorBlue,
                                                          value: AddressType
                                                              .HOME_ADDRESS,
                                                          materialTapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                          groupValue: state
                                                              .addAddressModel!
                                                              .addressType,
                                                          onChanged:
                                                              (AddressType?
                                                                  value) {
                                                            BlocProvider.of<
                                                                        AddressBookBloc>(
                                                                    blocContext)
                                                                .updateAddress(
                                                                    addressType:
                                                                        AddressType
                                                                            .HOME_ADDRESS);
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 30,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          'assets/images/address/icon_office.svg'),
                                                      Text('Office'),
                                                      SizedBox(
                                                        width: 26,
                                                        child:
                                                            Radio<AddressType>(
                                                          activeColor:
                                                              kTextColorBlue,
                                                          value: AddressType
                                                              .OFFICE_ADDRESS,
                                                          groupValue: state
                                                              .addAddressModel!
                                                              .addressType,
                                                          onChanged:
                                                              (AddressType?
                                                                  value) {
                                                            BlocProvider.of<
                                                                        AddressBookBloc>(
                                                                    blocContext)
                                                                .updateAddress(
                                                                    addressType:
                                                                        AddressType
                                                                            .OFFICE_ADDRESS);
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                    SizedBox(
                                      height: state.showCollapsedUi ? 50 : 60,
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          if (!state.savingAddress) {
                                            if (state.editingSavedAddress) {
                                              BlocProvider.of<AddressBookBloc>(
                                                      blocContext)
                                                  .editAddress(address!.id);
                                            } else {
                                              BlocProvider.of<AddressBookBloc>(
                                                      blocContext)
                                                  .addNewAddress();
                                            }
                                          }
                                        },
                                        child: Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          decoration:
                                              kActiveButtonContainerStyle,
                                          width: SizeConfig.screenWidth,
                                          child: Center(
                                            child: state.savingAddress
                                                ? CircularProgressIndicator(
                                                    color: Colors.white,
                                                  )
                                                : Text(
                                                    state.showCollapsedUi
                                                        ? 'Next'
                                                        : 'Save & Proceed',
                                                    style:
                                                        kActiveButtonTextStyle,
                                                  ),
                                          ),
                                        ))
                                  ]),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }
              },
            ),
          ),
        ));
  }

  void updateLocationOnMap(CameraPosition mapPosition) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(mapPosition));
  }

  StateData? getSelectedState(int stateId, List<StateData>? stateList) {
    StateData? result;
    if (stateList != null) {
      stateList.forEach((state) {
        if (state.id == stateId) result = state;
        return;
      });
    }
    return result;
  }

  Cities? getSelectedCity(int cityId, List<Cities>? cityList) {
    Cities? result;
    if (cityList != null) {
      cityList.forEach((city) {
        if (city.id == cityId) result = city;
        return;
      });
    }
    return result;
  }
}
