class PetHeroDetailResponse {
  List<Data> data = [];

  PetHeroDetailResponse({required this.data});

  PetHeroDetailResponse.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((v) {
      data.add(new Data.fromJson(v));
    });
  }
}

class Data {
  int? id;
  int? partnerableId;
  String? partnerableType;
  String? fullName;
  String? gender;
  String? dateOfBirth;
  bool? isActive;
  String? rating;
  bool? isListed;

  Data(
      {this.id,
      this.partnerableId,
      this.partnerableType,
      this.fullName,
      this.gender,
      this.dateOfBirth,
      this.isActive,
      this.rating,
      this.isListed});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    partnerableId = json['partnerable_id'];
    partnerableType = json['partnerable_type'];
    fullName = json['full_name'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    isActive = json['is_active'];
    rating = json['rating'];
    isListed = json['is_listed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['partnerable_id'] = this.partnerableId;
    data['partnerable_type'] = this.partnerableType;
    data['full_name'] = this.fullName;
    data['gender'] = this.gender;
    data['date_of_birth'] = this.dateOfBirth;
    data['is_active'] = this.isActive;
    data['rating'] = this.rating;
    data['is_listed'] = this.isListed;
    return data;
  }
}
