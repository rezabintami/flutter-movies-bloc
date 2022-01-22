part of 'now_playing_bloc.dart';

abstract class NowPlayingState extends Equatable {
  const NowPlayingState();

  @override
  List<Object> get props => [];
}

class NowPlayingInitial extends NowPlayingState {}

class NowPlayingLoading extends NowPlayingState {}

class NowPlayingLoaded extends NowPlayingState {
  final List<TV> tv;

  NowPlayingLoaded(this.tv);

  @override
  List<Object> get props => [tv];
}

class NowPlayingError extends NowPlayingState {
  final String message;

  NowPlayingError(this.message);

  @override
  List<Object> get props => [message];
}
