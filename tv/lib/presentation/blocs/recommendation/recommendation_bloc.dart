import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

part 'recommendation_event.dart';
part 'recommendation_state.dart';

class RecommendationBloc
    extends Bloc<RecommendationEvent, RecommendationState> {
  final GetTVRecommendations tvRecommendations;
  RecommendationBloc(this.tvRecommendations) : super(RecommendationInitial()) {
    on<RecommendationFetch>((event, emit) async {
      emit(RecommendationLoading());
      final result = await tvRecommendations.execute(event.id);
      result.fold(
        (failure) {
          emit(RecommendationError(failure.message));
        },
        (tvData) {
          emit(RecommendationLoaded(tvData));
        },
      );
    });
  }
}
