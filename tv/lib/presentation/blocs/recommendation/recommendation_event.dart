part of 'recommendation_bloc.dart';

abstract class RecommendationEvent extends Equatable {
  const RecommendationEvent();

  @override
  List<Object> get props => [];
}

class RecommendationFetch extends RecommendationEvent {
  final int id;
  RecommendationFetch(this.id);

  @override
  List<Object> get props => [id];
}
