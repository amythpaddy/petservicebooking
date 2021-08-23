class BookingConfirmationResponseModel {
  Data? data;

  BookingConfirmationResponseModel({this.data});

  BookingConfirmationResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Lead? lead;

  Data({this.lead});

  Data.fromJson(Map<String, dynamic> json) {
    lead = json['lead'] != null ? new Lead.fromJson(json['lead']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lead != null) {
      data['lead'] = this.lead!.toJson();
    }
    return data;
  }
}

class Lead {
  int? id;
  String? leadType;
  String? status;
  String? appointmentDatetime;
  String? additionalNote;
  String? leadUuid;
  String? orderUuid;
  int? rating;
  String? feedback;
  String? notes;
  LeadDetail? leadDetail;
  Null userLeadCoupon;
  List<LeadPetPackages>? leadPetPackages;

  Lead(
      {this.id,
      this.leadType,
      this.status,
      this.appointmentDatetime,
      this.additionalNote,
      this.leadUuid,
      this.orderUuid,
      this.rating,
      this.feedback,
      this.notes,
      this.leadDetail,
      this.userLeadCoupon,
      this.leadPetPackages});

  Lead.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leadType = json['lead_type'];
    status = json['status'];
    appointmentDatetime = json['appointment_datetime'];
    additionalNote = json['additional_note'];
    leadUuid = json['lead_uuid'];
    orderUuid = json['order_uuid'];
    rating = json['rating'];
    feedback = json['feedback'];
    notes = json['notes'];
    leadDetail = json['lead_detail'] != null
        ? new LeadDetail.fromJson(json['lead_detail'])
        : null;
    userLeadCoupon = json['user_lead_coupon'];
    if (json['lead_pet_packages'] != null) {
      leadPetPackages = [];
      json['lead_pet_packages'].forEach((v) {
        leadPetPackages!.add(new LeadPetPackages.fromJson(v));
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

class LeadDetail {
  int? id;
  String? name;
  String? email;
  String? lat;
  String? lng;
  Address? address;

  LeadDetail(
      {this.id, this.name, this.email, this.lat, this.lng, this.address});

  LeadDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    lat = json['lat'];
    lng = json['lng'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
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

class Address {
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

  Address(
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

  Address.fromJson(Map<String, dynamic> json) {
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

class LeadPetPackages {
  int? id;
  int? price;
  Package? package;
  CustomerPet? customerPet;

  LeadPetPackages({this.id, this.price, this.package, this.customerPet});

  LeadPetPackages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    package =
        json['package'] != null ? new Package.fromJson(json['package']) : null;
    customerPet = json['customer_pet'] != null
        ? new CustomerPet.fromJson(json['customer_pet'])
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

class Package {
  GroomerPackage? groomerPackage;

  Package({this.groomerPackage});

  Package.fromJson(Map<String, dynamic> json) {
    groomerPackage = json['groomer_package'] != null
        ? new GroomerPackage.fromJson(json['groomer_package'])
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

class GroomerPackage {
  int? id;
  int? groomerId;
  String? name;
  String? detail;
  String? price;
  int? active;
  String? city;
  String? petType;

  GroomerPackage(
      {this.id,
      this.groomerId,
      this.name,
      this.detail,
      this.price,
      this.active,
      this.city,
      this.petType});

  GroomerPackage.fromJson(Map<String, dynamic> json) {
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

class CustomerPet {
  int? id;
  String? name;
  String? aggression;
  String? gender;
  List<String>? images;
  bool? vaccinations;
  int? age;
  User? user;
  String? createdAt;
  double? weight;
  Category? category;
  Subcategory? subcategory;

  CustomerPet(
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

  CustomerPet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    aggression = json['aggression'];
    gender = json['gender'];
    images = json['images'].cast<String>();
    vaccinations = json['vaccinations'];
    age = json['age'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    createdAt = json['created_at'];
    weight = json['weight'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    subcategory = json['subcategory'] != null
        ? new Subcategory.fromJson(json['subcategory'])
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

class User {
  int? id;
  String? firstName;

  User({this.id, this.firstName});

  User.fromJson(Map<String, dynamic> json) {
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

class Category {
  String? name;

  Category({this.name});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class Subcategory {
  int? id;
  String? name;

  Subcategory({this.id, this.name});

  Subcategory.fromJson(Map<String, dynamic> json) {
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
