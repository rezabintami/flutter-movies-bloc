import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'recommendation_event.dart';
part 'recommendation_state.dart';

class RecommendationBloc extends Bloc<RecommendationEvent, RecommendationState> {
  RecommendationBloc() : super(RecommendationInitial()) {
    on<RecommendationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
