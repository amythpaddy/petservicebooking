import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:the_pet_nest/konstants/enums.dart';

class AddAddressRequestModel {
  String addressLineOne;
  String addressLineTwo;
  int cityId;
  String city;
  int stateId;
  String state;
  String zipCode;
  String country = "India";
  AddressType addressType;
  CameraPosition? mapPosition;

  AddAddressRequestModel({
    this.addressLineOne = "",
    this.addressLineTwo = "",
    this.cityId = -1,
    this.city = "",
    this.stateId = -1,
    this.state = "",
    this.zipCode = "",
    this.addressType = AddressType.HOME_ADDRESS,
    this.mapPosition,
  }) {
    mapPosition = CameraPosition(target: LatLng(28.7041, 77.1025));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map();
    data["address_line_one"] = addressLineOne;
    data["address_line_two"] = addressLineTwo;
    data["city_id"] = cityId;
    data["state_id"] = stateId;
    data["zipcode"] = zipCode;
    data["country"] = country;
    data["lat"] = mapPosition!.target.latitude;
    data["long"] = mapPosition!.target.longitude;
    final Map<String, dynamic> requestBody = Map();
    requestBody["address"] = data;
    return requestBody;
  }

  AddAddressRequestModel update(
      {String? addressLineOne,
      String? addressLineTwo,
      int? cityId,
      String? city,
      int? stateId,
      String? state,
      String? zipCode,
      AddressType? addressType,
      CameraPosition? mapPosition}) {
    return AddAddressRequestModel(
        addressType: addressType ?? this.addressType,
        addressLineOne: addressLineOne ?? this.addressLineOne,
        addressLineTwo: addressLineTwo ?? this.addressLineTwo,
        cityId: cityId ?? this.cityId,
        city: city ?? this.city,
        state: state ?? this.state,
        stateId: stateId ?? this.stateId,
        zipCode: zipCode ?? this.zipCode,
        mapPosition: mapPosition ?? this.mapPosition);
  }
}
