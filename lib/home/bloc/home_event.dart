part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class LoadApiEvent extends HomeEvent {
  @override
  //TODO: implement props
  List<Object?> get props => [];
}

class NoINternetEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}
