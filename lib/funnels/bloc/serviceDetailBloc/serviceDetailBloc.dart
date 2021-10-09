import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_pet_nest/funnels/bloc/serviceDetailBloc/serviceDetailEvent.dart';
import 'package:the_pet_nest/funnels/bloc/serviceDetailBloc/serviceDetailState.dart';
import 'package:the_pet_nest/funnels/model/petHeroDetailResponseModel.dart';
import 'package:the_pet_nest/konstants/endpoints.dart';
import 'package:the_pet_nest/utils/ApiCaller.dart';

class ServiceDetailBloc extends Bloc<ServiceDetailEvents, ServiceDetailState> {
  ServiceDetailBloc(ServiceDetailState initialState, {required String leadType})
      : super(initialState) {
    getPetHeroesList(leadType);
  }

  PetHeroDetailResponse? _petHeroesList;

  @override
  Stream<ServiceDetailState> mapEventToState(ServiceDetailEvents event) async* {
    if (event == ServiceDetailEvents.FETCHING_PET_HEROES) {
      yield state.copyWith(fetchingData: true);
    } else if (event == ServiceDetailEvents.PET_HERO_LIST_FETCHED) {
      yield state.copyWith(fetchingData: false, petHeroList: _petHeroesList);
    }
  }

  void getPetHeroesList(String leadType) async {
    add(ServiceDetailEvents.FETCHING_PET_HEROES);
    var response =
        await ApiCaller.get(kUrlGetPetHeroDetail(leadType), withToken: true);
    _petHeroesList = PetHeroDetailResponse.fromJson(response);
    add(ServiceDetailEvents.PET_HERO_LIST_FETCHED);
  }
}
