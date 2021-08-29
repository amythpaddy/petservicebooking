import 'package:equatable/equatable.dart';
import 'package:the_pet_nest/home/model/homeDataResponseModel.dart';

class HomeState extends Equatable {
  final bool loading;
  final HomeDataModel? homeData;
  final bool showAllPetHeroes;

  HomeState(
      {this.loading = true, this.homeData, this.showAllPetHeroes = false});
  HomeState copyWith(
      {bool? loading, HomeDataModel? homeData, bool? showAllPetHeroes}) {
    return HomeState(
        loading: loading ?? this.loading,
        homeData: homeData ?? this.homeData,
        showAllPetHeroes: showAllPetHeroes ?? this.showAllPetHeroes);
  }

  @override
  List<Object?> get props => [loading, homeData, showAllPetHeroes];
}
