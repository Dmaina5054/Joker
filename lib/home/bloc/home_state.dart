part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

//initial loading state
class HomeLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

//loaded state
class HomeLoadedState extends HomeState {
  final String jokeCategory;
  final String jokeType;
  final int jokeId;
  final String setup;
  final String delivery;

  const HomeLoadedState(
      this.jokeCategory, this.jokeType, this.jokeId, this.setup, this.delivery);
  @override
  //TODO: implement props
  List<Object?> get props => [jokeCategory, jokeType, jokeId, setup, delivery];
}

class HomeNoInternetState extends HomeState {
  @override
  List<Object?> get props => [];
}
