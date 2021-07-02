class ResponsePetBreed {
  List<Data>? data;

  ResponsePetBreed({this.data});

  ResponsePetBreed.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? id;
  String? name;
  List<Subcategories>? subcategories;

  Data({this.id, this.name, this.subcategories});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['subcategories'] != null) {
      subcategories = [];
      json['subcategories'].forEach((v) {
        subcategories!.add(new Subcategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.subcategories != null) {
      data['subcategories'] =
          this.subcategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subcategories {
  int? id;
  String? name;

  Subcategories({this.id, this.name});

  Subcategories.fromJson(Map<String, dynamic> json) {
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

class PetBreeds {
  final List<CatBreed> listOfCatBreed = [];
  final List<DogBreed> listOfDogBreed = [];

  void initData(ResponsePetBreed responseData) {
    for (Data data in responseData.data!) {
      if (data.name == 'Dog') {
        for (Subcategories breed in data.subcategories!) {
          DogBreed dogBreed =
              DogBreed(name: breed.name ?? '', id: breed.id ?? 0);
          listOfDogBreed.add(dogBreed);
        }
      } else {
        for (Subcategories breed in data.subcategories!) {
          CatBreed catBreed =
              CatBreed(name: breed.name ?? '', id: breed.id ?? 0);
          listOfCatBreed.add(catBreed);
        }
      }
    }
  }
}

abstract class BreedDetail {
  final int id;
  final String name;

  BreedDetail({required this.id, required this.name});
}

class DogBreed extends BreedDetail {
  DogBreed({required int id, required String name}) : super(id: id, name: name);
}

class CatBreed extends BreedDetail {
  CatBreed({required int id, required String name}) : super(id: id, name: name);
}
