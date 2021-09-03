import 'package:the_pet_nest/addressBook/model/addAddressResponseModel.dart';
import 'package:the_pet_nest/addressBook/model/savedAddressesAPIModel.dart';
import 'package:the_pet_nest/addressBook/model/statesAndCityApiModel.dart';
import 'package:the_pet_nest/konstants/enums.dart';

class AddressBookModel {
  List<Address> _addresses = [];
  List<Address> get address {
    return _addresses;
  }

  void addAddressFromSavedAddressList(
      SavedAddressResponse savedAddressResponse) {
    this._addresses = [];
    savedAddressResponse.data!.forEach((savedAddressData) {
      Address address = Address(
          id: savedAddressData.id!,
          addressableType: savedAddressData.addressableType!,
          addressLineOne: savedAddressData.addressLineOne!,
          addressLineTwo: savedAddressData.addressLineTwo!,
          zipCode: savedAddressData.zipcode!,
          country: savedAddressData.country!,
          lat: savedAddressData.lat!,
          long: savedAddressData.long!,
          addressType: savedAddressData.kind == "home"
              ? AddressType.HOME_ADDRESS
              : AddressType.OFFICE_ADDRESS,
          cityId: savedAddressData.city!.cityState!.id!,
          city: savedAddressData.city!.cityState!.name!,
          citySlug: savedAddressData.city!.cityState!.slug!,
          stateId: savedAddressData.city!.cityState!.state!.id!,
          state: savedAddressData.city!.cityState!.state!.name!,
          stateSlug: savedAddressData.city!.cityState!.state!.slug!);
      this._addresses.add(address);
    });
  }

  void addAddressFromAddedAddressResponse(
      AddEditAddressResponse addEditAddressResponse) {
    AddressResponse addressResponse = addEditAddressResponse.data!.address!;
    Address address = Address(
        id: addressResponse.id!,
        addressableType: addressResponse.addressableType!,
        addressLineOne: addressResponse.addressLineOne!,
        addressLineTwo: addressResponse.addressLineTwo!,
        zipCode: addressResponse.zipcode!,
        country: addressResponse.country!,
        lat: addressResponse.lat!,
        long: addressResponse.long!,
        addressType: addressResponse.kind == "home"
            ? AddressType.HOME_ADDRESS
            : AddressType.OFFICE_ADDRESS,
        cityId: addressResponse.city!.cityState!.id!,
        city: addressResponse.city!.cityState!.name!,
        citySlug: addressResponse.city!.cityState!.slug!,
        stateId: addressResponse.city!.cityState!.state!.id!,
        state: addressResponse.city!.cityState!.state!.name!,
        stateSlug: addressResponse.city!.cityState!.state!.slug!);
    _addresses.add(address);
  }

  void deleteFromAddressList(int id) {
    _addresses.removeWhere((address) => address.id == id);
  }
}

class Address {
  final int id;
  final String addressableType;
  final String addressLineOne;
  final String addressLineTwo;
  final int zipCode;
  final String country;
  final double lat;
  final double long;
  final AddressType addressType;
  final int cityId;
  final String city;
  final String citySlug;
  final int stateId;
  final String state;
  final String stateSlug;

  Address(
      {required this.id,
      required this.addressableType,
      required this.addressLineOne,
      required this.addressLineTwo,
      required this.zipCode,
      required this.country,
      required this.lat,
      required this.long,
      required this.addressType,
      required this.cityId,
      required this.city,
      required this.citySlug,
      required this.stateId,
      required this.state,
      required this.stateSlug});
}

class CityList {
  List<CityDetail> _cityList = [];
  List<CityDetail> get cityList => _cityList;

  void createCityListFromCityStateList(StatesAndCitiesResponse response) {
    response.stateList!.forEach((stateData) {
      stateData.cities!.forEach((cityData) {
        CityDetail cityDetail =
            CityDetail(cityId: cityData.id, cityName: cityData.cityName);
        cityList.add(cityDetail);
      });
    });
  }
}

class CityDetail {
  String cityName;
  int cityId;
  String citySlug;
  CityDetail({this.cityId = -1, this.cityName = "", this.citySlug = ""});
}
