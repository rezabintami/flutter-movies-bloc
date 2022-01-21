part of 'popular_bloc.dart';

abstract class PopularState extends Equatable {
  const PopularState();
  
  @override
  List<Object> get props => [];
}

class PopularInitial extends PopularState {}
