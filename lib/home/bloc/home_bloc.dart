import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:mpya/services/connectivityService.dart';
import 'package:mpya/services/jokeService.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final JokeService _jokeService;
  final ConnectivityService _connectivityService;

  HomeBloc(this._jokeService, this._connectivityService)
      : super(HomeLoadingState()) {
    _connectivityService.connectactivityStream.stream.listen((event) {
      if (event == ConnectivityResult.none) {
        add(NoINternetEvent());
        print('No internet');
      } else {
        print('Yesy internet');
        add(LoadApiEvent());
      }
    });

    on<LoadApiEvent>((event, emit) async {
      //show loading event then api results
      emit(HomeLoadingState());
      // TODO: implement event handler
      final joke = await _jokeService.getJokeActivity();
      emit(HomeLoadedState(
          joke.category, joke.type, joke.id, joke.delivery, joke.setup));
    });

    //on no internet event
    on<NoINternetEvent>((event, emit) {
      emit(HomeNoInternetState());
    });
  }
}
