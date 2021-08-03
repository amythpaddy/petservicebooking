class StatesAndCitiesResponse {
  List<StateData>? stateList;

  StatesAndCitiesResponse({this.stateList});

  StatesAndCitiesResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      stateList = [];
      json['data'].forEach((v) {
        stateList!.add(new StateData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stateList != null) {
      data['data'] = this.stateList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StateData {
  int? id;
  String? slug;
  String? name;
  List<Cities>? cities;

  StateData({this.id, this.slug, this.name, this.cities});

  StateData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    name = json['name'];
    if (json['cities'] != null) {
      cities = [];
      json['cities'].forEach((v) {
        cities!.add(new Cities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['name'] = this.name;
    if (this.cities != null) {
      data['cities'] = this.cities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cities {
  int? id;
  String? slug;
  String? cityName;

  Cities({this.id, this.slug, this.cityName});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    cityName = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['name'] = this.cityName;
    return data;
  }
}
