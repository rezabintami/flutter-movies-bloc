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
  final TVDetail tv;

  const AddToWatchlist(this.tv);

  @override
  List<Object> get props => [tv];
}

class RemoveFromWatchlist extends DetailEvent {
  final TVDetail tv;

  const RemoveFromWatchlist(this.tv);

  @override
  List<Object> get props => [tv];
}

class LoadStatusWatchlist extends DetailEvent {
  final int id;

  const LoadStatusWatchlist(this.id);

  @override
  List<Object> get props => [id];
}
