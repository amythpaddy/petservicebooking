class AddressListResponse {
  List<Data> data = [];
  AddressListResponse() {
    this.data.add(Data());
  }
}

class Data {
  String address1;
  String address2;
  String city;
  Data({this.address1: 'Line 1', this.address2: 'Line 2', this.city: 'City'});
}
