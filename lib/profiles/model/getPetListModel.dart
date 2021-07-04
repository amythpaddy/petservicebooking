class PetList {
  PetList();
  List<PetCURLModel> petList = [];
  PetList.fromJson(Map<String, dynamic> json) {
    List<dynamic> data = json['data'];
    // data.forEach((element) { })
  }

  void add(PetCURLModel petCreatedResponse) {
    petList.add(petCreatedResponse);
  }
}

class ResponseGetPet {
  List<CustomerPet>? data;

  ResponseGetPet({this.data});

  ResponseGetPet.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new CustomerPet.fromJson(v));
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

class PetCURLModel {
  Data? data;

  PetCURLModel({this.data});

  PetCURLModel.fromJson(Map<String, dynamic> json) {
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
  CustomerPet? customerPet;

  Data({this.customerPet});

  Data.fromJson(Map<String, dynamic> json) {
    customerPet = json['customer_pet'] != null
        ? new CustomerPet.fromJson(json['customer_pet'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customerPet != null) {
      data['customer_pet'] = this.customerPet!.toJson();
    }
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

class PetDataStore {
  List<CustomerPet> petDataStore = [];
  void getList(ResponseGetPet petData) {
    petDataStore = [];
    petData.data!.forEach((element) {
      petDataStore.add(element);
    });
  }

  void addToList(PetCURLModel petData) {
    CustomerPet? customerPet = petData.data!.customerPet;
    if (customerPet != null) petDataStore.add(customerPet);
  }
}
