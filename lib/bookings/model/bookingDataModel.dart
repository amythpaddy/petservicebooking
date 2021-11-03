class BookingsDataResponseModel {
  _Meta? meta;
  List<BookingData>? data;

  BookingsDataResponseModel({this.meta, this.data});

  BookingsDataResponseModel.fromJson(
      Map<String, dynamic> json, String leadType) {
    // meta = json['meta'] != null ? new _Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new BookingData.fromJson(v, leadType));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // if (this.meta != null) {
    //   data['meta'] = this.meta!.toJson();
    // }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class _Meta {
  int? page;
  int? perPage;
  int? totalCount;
  int? currentCount;

  _Meta({this.page, this.perPage, this.totalCount, this.currentCount});

  _Meta.fromJson(Map<String, dynamic> json) {
    page = int.parse(json['page'], radix: 10);
    perPage = json['per_page'];
    totalCount = json['total_count'];
    currentCount = json['current_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['per_page'] = this.perPage;
    data['total_count'] = this.totalCount;
    data['current_count'] = this.currentCount;
    return data;
  }
}

class BookingData {
  int? id;
  String? leadType;
  String? status;
  String? appointmentDatetime;
  String? additionalNote;
  String? leadUuid;
  String? orderUuid;
  int? rating;
  String? feedback;
  int? notes;
  PetHero? petHero;
  List<_LeadPetPackages>? leadPetPackages;

  BookingData.fromJson(Map<String, dynamic> json, String leadType) {
    id = json['id'];
    this.leadType = leadType;
    status = json['status'];
    appointmentDatetime = json['appointment_datetime'];
    additionalNote = json['additional_note'];
    leadUuid = json['lead_uuid'];
    orderUuid = json['order_uuid'];
    rating = json['rating'];
    feedback = json['feedback'];
    notes = json['notes'];
    petHero = json['pet_hero'] != null
        ? new PetHero.fromJson(json['pet_hero'])
        : null;
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
    data['pet_hero'] = this.petHero;
    if (this.leadPetPackages != null) {
      data['lead_pet_packages'] =
          this.leadPetPackages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PetHero {
  String? name;
  String? rating;
  int? jobsDone;
  PetHero.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    rating = json['rating'];
    jobsDone = json['jobs_done'];
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
  int? categoryId;
  int? subcategoryId;
  String? name;
  String? aggression;
  String? gender;
  bool? vaccinations;
  int? age;
  String? createdAt;
  double? weight;

  _CustomerPet(
      {this.id,
      this.categoryId,
      this.subcategoryId,
      this.name,
      this.aggression,
      this.gender,
      this.vaccinations,
      this.age,
      this.createdAt,
      this.weight});

  _CustomerPet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    name = json['name'];
    aggression = json['aggression'];
    gender = json['gender'];
    vaccinations = json['vaccinations'];
    age = json['age'];
    createdAt = json['created_at'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['name'] = this.name;
    data['aggression'] = this.aggression;
    data['gender'] = this.gender;
    data['vaccinations'] = this.vaccinations;
    data['age'] = this.age;
    data['created_at'] = this.createdAt;
    data['weight'] = this.weight;
    return data;
  }
}
