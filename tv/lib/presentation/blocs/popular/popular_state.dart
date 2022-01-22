part of 'popular_bloc.dart';

abstract class PopularState extends Equatable {
  const PopularState();

  @override
  List<Object> get props => [];
}

class PopularInitial extends PopularState {}

class PopularLoading extends PopularState {}

class PopularLoaded extends PopularState {
  final List<TV> tv;

  PopularLoaded(this.tv);

  @override
  List<Object> get props => [tv];
}

class PopularError extends PopularState {
  final String message;

  PopularError(this.message);

  @override
  List<Object> get props => [message];
}
