class SavedAddressResponse {
  List<SavedAddressData>? data;

  SavedAddressResponse({this.data});

  SavedAddressResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new SavedAddressData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SavedAddressData {
  int? id;
  String? addressableType;
  int? addressableId;
  String? addressLineOne;
  String? addressLineTwo;
  int? zipcode;
  String? country;
  String? createdAt;
  City? city;
  double? lat;
  double? long;
  String? kind;

  SavedAddressData(
      {this.id,
      this.addressableType,
      this.addressableId,
      this.addressLineOne,
      this.addressLineTwo,
      this.zipcode,
      this.country,
      this.createdAt,
      this.city,
      this.lat,
      this.long,
      this.kind});

  SavedAddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addressableType = json['addressable_type'];
    addressableId = json['addressable_id'];
    addressLineOne = json['address_line_one'];
    addressLineTwo = json['address_line_two'];
    zipcode = json['zipcode'];
    country = json['country'];
    createdAt = json['created_at'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    lat = json['lat'];
    long = json['long'];
    kind = json['kind'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['addressable_type'] = this.addressableType;
    data['addressable_id'] = this.addressableId;
    data['address_line_one'] = this.addressLineOne;
    data['address_line_two'] = this.addressLineTwo;
    data['zipcode'] = this.zipcode;
    data['country'] = this.country;
    data['created_at'] = this.createdAt;
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['kind'] = this.kind;
    return data;
  }
}

class City {
  CityState? cityState;

  City({this.cityState});

  City.fromJson(Map<String, dynamic> json) {
    cityState = json['city_state'] != null
        ? new CityState.fromJson(json['city_state'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cityState != null) {
      data['city_state'] = this.cityState!.toJson();
    }
    return data;
  }
}

class CityState {
  int? id;
  String? slug;
  String? name;
  State? state;

  CityState({this.id, this.slug, this.name, this.state});

  CityState.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    name = json['name'];
    state = json['state'] != null ? new State.fromJson(json['state']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['name'] = this.name;
    if (this.state != null) {
      data['state'] = this.state!.toJson();
    }
    return data;
  }
}

class State {
  int? id;
  String? name;
  String? slug;
  String? createdAt;
  String? updatedAt;

  State({this.id, this.name, this.slug, this.createdAt, this.updatedAt});

  State.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
