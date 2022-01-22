import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';

part 'top_rated_event.dart';
part 'top_rated_state.dart';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  final GetTopRatedMovies getTopRatedMovies;
  TopRatedBloc(this.getTopRatedMovies) : super(TopRatedInitial()) {
    on<TopRatedFetch>((event, emit) async {
      emit(TopRatedLoading());
      final result = await getTopRatedMovies.execute();
      result.fold(
        (failure) => emit(TopRatedError(failure.message)),
        (movie) => emit(TopRatedLoaded(movie)),
      );
    });
  }
}
