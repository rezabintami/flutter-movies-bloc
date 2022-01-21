part of 'recommendation_bloc.dart';

abstract class RecommendationState extends Equatable {
  const RecommendationState();
  
  @override
  List<Object> get props => [];
}

class RecommendationInitial extends RecommendationState {}
