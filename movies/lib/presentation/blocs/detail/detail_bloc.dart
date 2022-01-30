import 'package:bloc/bloc.dart';
import 'package:core/utils/state_enum.dart';
import 'package:ditonton/domain/usecases/get_movie_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_movie_watchlist.dart';
import 'package:ditonton/domain/usecases/save_movie_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/genre.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetMovieWatchListStatus getMovieWatchListStatus;
  final SaveMovieWatchlist saveMovieWatchlist;
  final RemoveMovieWatchlist removeMovieWatchlist;
  DetailBloc(
      {required this.getMovieDetail,
      required this.getMovieRecommendations,
      required this.getMovieWatchListStatus,
      required this.saveMovieWatchlist,
      required this.removeMovieWatchlist})
      : super(DetailState.initial()) {
    on<RequestDetail>((event, emit) async {
      int id = event.id;
      emit(state.copyWith(movieDetailState: RequestState.Loading));
      final detailResult = await getMovieDetail.execute(id);
      final recommendationResult = await getMovieRecommendations.execute(id);
      detailResult.fold(
        (failure) async {
          emit(state.copyWith(
              movieDetailState: RequestState.Error, message: failure.message));
        },
        (movie) async {
          emit(state.copyWith(
            movieRecommendationsState: RequestState.Loading,
            movieDetail: movie,
            movieDetailState: RequestState.Loaded,
            message: '',
          ));
          recommendationResult.fold(
            (failure) {
              emit(state.copyWith(
                  movieRecommendationsState: RequestState.Error,
                  message: failure.message));
            },
            (movies) {
              emit(state.copyWith(
                movieRecommendationsState: RequestState.Loaded,
                movieRecommendations: movies,
                message: '',
              ));
            },
          );
        },
      );
    });

    on<AddToWatchlist>((event, emit) async {
      final watchListResult = await saveMovieWatchlist.execute(event.movie);
      watchListResult.fold(
        (failure) {
          emit(state.copyWith(watchlistMessage: failure.message));
        },
        (message) {
          emit(state.copyWith(watchlistMessage: message));
        },
      );
      add(LoadStatusWatchlist(event.movie.id));
    });

    on<RemoveFromWatchlist>((event, emit) async {
      final watchListResult = await removeMovieWatchlist.execute(event.movie);
      watchListResult.fold(
        (failure) {
          emit(state.copyWith(watchlistMessage: failure.message));
        },
        (message) {
          emit(state.copyWith(watchlistMessage: message));
        },
      );
      add(LoadStatusWatchlist(event.movie.id));
    });

    on<LoadStatusWatchlist>((event, emit) async {
      bool watchListResult = await getMovieWatchListStatus.execute(event.id);
      emit(state.copyWith(isAddedToWatchlist: watchListResult, message: ''));
    });
  }
}
