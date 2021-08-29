import 'package:the_pet_nest/bookings/model/bookingDataModel.dart';

class BookingConfirmationResponseModel {
  BookingConfirmationData? data;

  BookingConfirmationResponseModel({this.data});

  BookingConfirmationResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new BookingConfirmationData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class BookingConfirmationData {
  _Lead? lead;

  BookingConfirmationData({this.lead});

  BookingConfirmationData.fromJson(Map<String, dynamic> json) {
    lead = json['lead'] != null ? new _Lead.fromJson(json['lead']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lead != null) {
      data['lead'] = this.lead!.toJson();
    }
    return data;
  }
}

class _Lead {
  int? id;
  String? leadType;
  String? status;
  String? appointmentDatetime;
  String? additionalNote;
  String? leadUuid;
  String? orderUuid;
  int? rating;
  String? feedback;
  PetHero? petHero;
  String? notes;
  _LeadDetail? leadDetail;
  Null userLeadCoupon;
  List<_LeadPetPackages>? leadPetPackages;

  _Lead(
      {this.id,
      this.leadType,
      this.status,
      this.appointmentDatetime,
      this.additionalNote,
      this.leadUuid,
      this.orderUuid,
      this.rating,
      this.feedback,
      this.petHero,
      this.notes,
      this.leadDetail,
      this.userLeadCoupon,
      this.leadPetPackages});

  _Lead.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leadType = json['lead_type'];
    status = json['status'];
    appointmentDatetime = json['appointment_datetime'];
    additionalNote = json['additional_note'];
    leadUuid = json['lead_uuid'];
    orderUuid = json['order_uuid'];
    rating = json['rating'];
    feedback = json['feedback'];
    petHero = json['pet_hero'];
    notes = json['notes'];
    leadDetail = json['lead_detail'] != null
        ? new _LeadDetail.fromJson(json['lead_detail'])
        : null;
    userLeadCoupon = json['user_lead_coupon'];
    if (json['lead_pet_packages'] != null) {
      leadPetPackages = [];
      json['lead_pet_packages'].forEach((v) {
        leadPetPackages!.add(new _LeadPetPackages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lead_type'] = this.leadType;
    data['status'] = this.status;
    data['appointment_datetime'] = this.appointmentDatetime;
    data['additional_note'] = this.additionalNote;
    data['lead_uuid'] = this.leadUuid;
    data['order_uuid'] = this.orderUuid;
    data['rating'] = this.rating;
    data['feedback'] = this.feedback;
    data['notes'] = this.notes;
    if (this.leadDetail != null) {
      data['lead_detail'] = this.leadDetail!.toJson();
    }
    data['user_lead_coupon'] = this.userLeadCoupon;
    if (this.leadPetPackages != null) {
      data['lead_pet_packages'] =
          this.leadPetPackages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class _LeadDetail {
  int? id;
  String? name;
  String? email;
  String? lat;
  String? lng;
  _Address? address;

  _LeadDetail(
      {this.id, this.name, this.email, this.lat, this.lng, this.address});

  _LeadDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    lat = json['lat'];
    lng = json['lng'];
    address =
        json['address'] != null ? new _Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    return data;
  }
}

class _Address {
  int? id;
  String? addressableType;
  int? addressableId;
  String? addressLineOne;
  String? addressLineTwo;
  int? zipcode;
  String? country;
  String? createdAt;
  _City? city;
  double? lat;
  double? long;
  String? kind;

  _Address(
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

  _Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addressableType = json['addressable_type'];
    addressableId = json['addressable_id'];
    addressLineOne = json['address_line_one'];
    addressLineTwo = json['address_line_two'];
    zipcode = json['zipcode'];
    country = json['country'];
    createdAt = json['created_at'];
    city = json['city'] != null ? new _City.fromJson(json['city']) : null;
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

class _City {
  _CityState? cityState;

  _City({this.cityState});

  _City.fromJson(Map<String, dynamic> json) {
    cityState = json['city_state'] != null
        ? new _CityState.fromJson(json['city_state'])
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

class _CityState {
  int? id;
  String? slug;
  String? name;
  _State? state;

  _CityState({this.id, this.slug, this.name, this.state});

  _CityState.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    name = json['name'];
    state = json['state'] != null ? new _State.fromJson(json['state']) : null;
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

class _State {
  int? id;
  String? name;
  String? slug;
  String? createdAt;
  String? updatedAt;

  _State({this.id, this.name, this.slug, this.createdAt, this.updatedAt});

  _State.fromJson(Map<String, dynamic> json) {
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

class _LeadPetPackages {
  int? id;
  double? price;
  _Package? package;
  _CustomerPet? customerPet;

  _LeadPetPackages({this.id, this.price, this.package, this.customerPet});

  _LeadPetPackages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    package =
        json['package'] != null ? new _Package.fromJson(json['package']) : null;
    customerPet = json['customer_pet'] != null
        ? new _CustomerPet.fromJson(json['customer_pet'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    if (this.package != null) {
      data['package'] = this.package!.toJson();
    }
    if (this.customerPet != null) {
      data['customer_pet'] = this.customerPet!.toJson();
    }
    return data;
  }
}

class _Package {
  _GroomerPackage? groomerPackage;

  _Package({this.groomerPackage});

  _Package.fromJson(Map<String, dynamic> json) {
    groomerPackage = json['groomer_package'] != null
        ? new _GroomerPackage.fromJson(json['groomer_package'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.groomerPackage != null) {
      data['groomer_package'] = this.groomerPackage!.toJson();
    }
    return data;
  }
}

class _GroomerPackage {
  int? id;
  int? groomerId;
  String? name;
  String? detail;
  String? price;
  int? active;
  String? city;
  String? petType;

  _GroomerPackage(
      {this.id,
      this.groomerId,
      this.name,
      this.detail,
      this.price,
      this.active,
      this.city,
      this.petType});

  _GroomerPackage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groomerId = json['groomer_id'];
    name = json['name'];
    detail = json['detail'];
    price = json['price'];
    active = json['active'];
    city = json['city'];
    petType = json['pet_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['groomer_id'] = this.groomerId;
    data['name'] = this.name;
    data['detail'] = this.detail;
    data['price'] = this.price;
    data['active'] = this.active;
    data['city'] = this.city;
    data['pet_type'] = this.petType;
    return data;
  }
}

class _CustomerPet {
  int? id;
  String? name;
  String? aggression;
  String? gender;
  List<String>? images;
  bool? vaccinations;
  int? age;
  _User? user;
  String? createdAt;
  double? weight;
  _Category? category;
  _Subcategory? subcategory;

  _CustomerPet(
      {this.id,
      this.name,
      this.aggression,
      this.gender,
      this.images,
      this.vaccinations,
      this.age,
      this.user,
      this.createdAt,
      this.weight,
      this.category,
      this.subcategory});

  _CustomerPet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    aggression = json['aggression'];
    gender = json['gender'];
    images = json['images'].cast<String>();
    vaccinations = json['vaccinations'];
    age = json['age'];
    user = json['user'] != null ? new _User.fromJson(json['user']) : null;
    createdAt = json['created_at'];
    weight = json['weight'];
    category = json['category'] != null
        ? new _Category.fromJson(json['category'])
        : null;
    subcategory = json['subcategory'] != null
        ? new _Subcategory.fromJson(json['subcategory'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['aggression'] = this.aggression;
    data['gender'] = this.gender;
    data['images'] = this.images;
    data['vaccinations'] = this.vaccinations;
    data['age'] = this.age;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['weight'] = this.weight;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.subcategory != null) {
      data['subcategory'] = this.subcategory!.toJson();
    }
    return data;
  }
}

class _User {
  int? id;
  String? firstName;

  _User({this.id, this.firstName});

  _User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    return data;
  }
}

class _Category {
  String? name;

  _Category({this.name});

  _Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class _Subcategory {
  int? id;
  String? name;

  _Subcategory({this.id, this.name});

  _Subcategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
