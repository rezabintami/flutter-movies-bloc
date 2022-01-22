part of 'top_rated_bloc.dart';

abstract class TopRatedState extends Equatable {
  const TopRatedState();

  @override
  List<Object> get props => [];
}

class TopRatedInitial extends TopRatedState {}

class TopRatedLoading extends TopRatedState {}

class TopRatedLoaded extends TopRatedState {
  final List<TV> tv;

  TopRatedLoaded(this.tv);

  @override
  List<Object> get props => [tv];
}

class TopRatedError extends TopRatedState {
  final String message;

  TopRatedError(this.message);

  @override
  List<Object> get props => [message];
}
