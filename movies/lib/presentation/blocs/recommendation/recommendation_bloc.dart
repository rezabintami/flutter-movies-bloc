import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/entities.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';

part 'recommendation_event.dart';
part 'recommendation_state.dart';

class RecommendationBloc
    extends Bloc<RecommendationEvent, RecommendationState> {
  final GetMovieRecommendations getMovieRecommendations;

  RecommendationBloc(this.getMovieRecommendations)
      : super(RecommendationInitial()) {
    on<RecommendationFetch>((event, emit) async {
      final id = event.id;

      emit(RecommendationLoading());
      final result = await getMovieRecommendations.execute(id);

      result.fold(
        (failure) => emit(RecommendationError(failure.message)),
        (movie) => emit(RecommendationLoaded(movie)),
      );
    });
  }
}
