part of 'popular_bloc.dart';

abstract class PopularState extends Equatable {
  const PopularState();

  @override
  List<Object> get props => [];
}

class PopularInitial extends PopularState {}

class PopularLoading extends PopularState {}

class PopularLoaded extends PopularState {
  final List<Movie> movies;

  const PopularLoaded(this.movies);
  @override
  List<Object> get props => [];
}

class PopularError extends PopularState {
  final String message;

  const PopularError(this.message);
  @override
  List<Object> get props => [];
}
