part of 'watchlist_bloc.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object> get props => [];
}

class WatchlistFetch extends WatchlistEvent {
  WatchlistFetch();

  @override
  List<Object> get props => [];
}
