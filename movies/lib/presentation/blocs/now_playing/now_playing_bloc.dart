import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/entities.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';

part 'now_playing_event.dart';
part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingBloc(this.getNowPlayingMovies) : super(NowPlayingInitial()) {
    on<NowPlayingFetch>((event, emit) async {
      emit(NowPlayingLoading());
      final result = await getNowPlayingMovies.execute();

      result.fold(
        (failure) => emit(NowPlayingError(failure.message)),
        (movies) => emit(NowPlayingLoaded(movies)),
      );
    });
  }
}
