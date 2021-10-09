import 'package:equatable/equatable.dart';
import 'package:the_pet_nest/funnels/model/petHeroDetailResponseModel.dart';

class ServiceDetailState extends Equatable {
  final PetHeroDetailResponse? petHeroList;
  final bool fetchingData;
  ServiceDetailState({this.petHeroList, this.fetchingData = true});
  ServiceDetailState copyWith(
      {PetHeroDetailResponse? petHeroList, bool? fetchingData}) {
    return ServiceDetailState(
        petHeroList: petHeroList ?? this.petHeroList,
        fetchingData: fetchingData ?? this.fetchingData);
  }

  @override
  List<Object?> get props => [petHeroList, fetchingData];
}
