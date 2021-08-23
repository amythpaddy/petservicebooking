class PackagesListResponse {
  List<PackageDetailModel>? data;

  PackagesListResponse({this.data});

  PackagesListResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new PackageDetailModel.fromJson(v));
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

class PackageDetailModel {
  int? id;
  int? groomerId;
  String? name;
  String? detail;
  String? price;
  int? active;
  String? city;
  String? petType;

  PackageDetailModel(
      {this.id,
      this.groomerId,
      this.name,
      this.detail,
      this.price,
      this.active,
      this.city,
      this.petType});

  PackageDetailModel.fromJson(Map<String, dynamic> json) {
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
