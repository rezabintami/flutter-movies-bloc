part of 'now_playing_bloc.dart';

abstract class NowPlayingState extends Equatable {
  const NowPlayingState();

  @override
  List<Object> get props => [];
}

class NowPlayingInitial extends NowPlayingState {}

class NowPlayingLoading extends NowPlayingState {}

class NowPlayingLoaded extends NowPlayingState {
  final List<Movie> movies;

  const NowPlayingLoaded(this.movies);
  @override
  List<Object> get props => [movies];
}

class NowPlayingError extends NowPlayingState {
  final String message;

  const NowPlayingError(this.message);
  @override
  List<Object> get props => [message];
}
