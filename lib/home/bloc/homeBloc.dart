import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_pet_nest/home/bloc/homeEvent.dart';
import 'package:the_pet_nest/home/bloc/homeState.dart';
import 'package:the_pet_nest/home/model/homeDataResponseModel.dart';
import 'package:the_pet_nest/konstants/endpoints.dart';
import 'package:the_pet_nest/utils/ApiCaller.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(HomeState initialState) : super(initialState) {
    getHomeScreenData();
  }
  HomeDataModel? _homeData;

  void getHomeScreenData() async {
    var response = await ApiCaller.get(kUrlGetHomeData);
    _homeData = HomeDataResponseModel.fromJson(response).data!;
    add(HomeEvent.HOME_DATA_FETCHED);
  }

  void showMorePetHeroes() {
    add(HomeEvent.SHOW_MORE_PET_HEROES);
  }

  void showLessPetHeroes() {
    add(HomeEvent.SHOW_LESS_PET_HEROES);
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event == HomeEvent.HOME_DATA_FETCHED) {
      yield state.copyWith(loading: false, homeData: _homeData);
    } else if (event == HomeEvent.SHOW_LESS_PET_HEROES) {
      yield state.copyWith(showAllPetHeroes: false);
    } else if (event == HomeEvent.SHOW_MORE_PET_HEROES) {
      yield state.copyWith(showAllPetHeroes: true);
    }
  }
}
