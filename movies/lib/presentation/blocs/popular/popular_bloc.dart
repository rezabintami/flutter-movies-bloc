import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_popular_movies.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  final GetPopularMovies getPopularMovies;
  PopularBloc(this.getPopularMovies) : super(PopularInitial()) {
    on<PopularFetch>((event, emit) async {
      emit(PopularLoading());
      final result = await getPopularMovies.execute();
      result.fold(
        (failure) => emit(PopularError(failure.message)),
        (movies) => emit(PopularLoaded(movies)),
      );
    });
  }
}
