part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object> get props => [];
}

class RequestDetail extends DetailEvent {
  final int id;

  const RequestDetail(this.id);

  @override
  List<Object> get props => [id];
}

class AddToWatchlist extends DetailEvent {
  final MovieDetail movie;

  const AddToWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class RemoveFromWatchlist extends DetailEvent {
  final MovieDetail movie;

  const RemoveFromWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class LoadStatusWatchlist extends DetailEvent {
  final int id;

  const LoadStatusWatchlist(this.id);

  @override
  List<Object> get props => [id];
}
