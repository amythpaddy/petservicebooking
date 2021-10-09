import 'package:the_pet_nest/bookings/model/bookingDataModel.dart';

class BookingConfirmationResponseModel {
  BookingConfirmationData? data;

  BookingConfirmationResponseModel({this.data});

  BookingConfirmationResponseModel.fromJson(
      Map<String, dynamic> json, String leadType) {
    data = json['data'] != null
        ? new BookingConfirmationData.fromJson(json['data'], leadType)
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

  BookingConfirmationData.fromJson(Map<String, dynamic> json, String leadType) {
    if (json['lead'] != null)
      lead = _Lead.fromJson(json['lead'], leadType);
    else if (json['dog_training_lead'] != null)
      lead = _Lead.fromJson(json['dog_training_lead'], leadType);
    else if (json['vet_lead'] != null)
      lead = _Lead.fromJson(json['vet_lead'], leadType);
    else
      lead = null;
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
  String? paymentStatus;
  _Price? price;
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
      this.leadPetPackages,
      this.paymentStatus,
      this.price});

  _Lead.fromJson(Map<String, dynamic> json, String leadType) {
    id = json['id'];
    leadType = leadType;
    status = json['status'];
    appointmentDatetime =
        json['appointment_datetime'] ?? json['appointment_date'];
    additionalNote = json['additional_note'];
    leadUuid = json['lead_uuid'];
    orderUuid = json['order_uuid'];
    rating = json['rating'];
    feedback = json['feedback'];
    petHero = json['pet_hero'];
    notes = json['notes'];
    paymentStatus = json['payment_status'];
    price = json['price'] != null ? new _Price.fromJson(json['price']) : null;
    leadDetail = json['lead_detail'] != null
        ? new _LeadDetail.fromJson(json['lead_detail'])
        : null;
    userLeadCoupon = json['user_lead_coupon'];
    leadPetPackages = [];
    if (json['lead_pet_packages'] != null) {
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
  _PackageDetails? packageDetails;

  _Package({this.packageDetails});

  _Package.fromJson(Map<String, dynamic> json) {
    if (json['groomer_package'] != null) {
      packageDetails = _PackageDetails.fromJson(json['groomer_package']);
    } else if (json['dog_training_package'] != null) {
      packageDetails = _PackageDetails.fromJson(json['dog_training_package']);
    } else if (json['vet_package'] != null) {
      packageDetails = _PackageDetails.fromJson(json['vet_package']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.packageDetails != null) {
      data['groomer_package'] = this.packageDetails!.toJson();
    }
    return data;
  }
}

class _PackageDetails {
  int? id;
  int? groomerId;
  String? name;
  String? detail;
  String? price;
  String? city;
  String? petType;

  _PackageDetails(
      {this.id,
      this.groomerId,
      this.name,
      this.detail,
      this.price,
      this.city,
      this.petType});

  _PackageDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groomerId = json['groomer_id'];
    name = json['name'];
    detail = json['detail'];
    price = json['price'].toString();
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

class _Price {
  String? totalPrice;
  String? discountPrice;
  String? grossPrice;
  String? netPrice;

  _Price({this.totalPrice, this.discountPrice, this.grossPrice, this.netPrice});

  _Price.fromJson(Map<String, dynamic> json) {
    totalPrice = json['total_price'].toString();
    discountPrice = json['discount_price'].toString();
    grossPrice = json['gross_price'].toString();
    netPrice = json['net_price'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_price'] = this.totalPrice;
    data['discount_price'] = this.discountPrice;
    data['gross_price'] = this.grossPrice;
    data['net_price'] = this.netPrice;
    return data;
  }
}
