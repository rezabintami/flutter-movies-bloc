import 'package:bloc/bloc.dart';
import 'package:core/utils/state_enum.dart';
import 'package:ditonton/domain/usecases/get_tv_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final GetTVDetail getTVDetail;
  final GetTVRecommendations getTVRecommendations;
  final GetTVWatchListStatus getTVWatchListStatus;
  final SaveTVWatchlist saveTVWatchList;
  final RemoveTVWatchlist removeTVWatchList;
  DetailBloc(
      {required this.getTVDetail,
      required this.getTVRecommendations,
      required this.getTVWatchListStatus,
      required this.saveTVWatchList,
      required this.removeTVWatchList})
      : super(DetailState.initial()) {
    on<RequestDetail>((event, emit) async {
      int id = event.id;
      emit(state.copyWith(tvDetailState: RequestState.Loading));
      final detailResult = await getTVDetail.execute(id);
      final recommendationResult = await getTVRecommendations.execute(id);
      detailResult.fold(
        (failure) async {
          emit(state.copyWith(
              tvDetailState: RequestState.Error, message: failure.message));
        },
        (tv) async {
          emit(state.copyWith(
            tvRecommendationsState: RequestState.Loading,
            tvDetail: tv,
            tvDetailState: RequestState.Loaded,
            message: '',
          ));
          recommendationResult.fold(
            (failure) {
              emit(state.copyWith(
                  tvRecommendationsState: RequestState.Error,
                  message: failure.message));
            },
            (tv) {
              emit(state.copyWith(
                tvRecommendationsState: RequestState.Loaded,
                tvRecommendations: tv,
                message: '',
              ));
            },
          );
        },
      );
    });

    on<AddToWatchlist>((event, emit) async {
      final watchListResult = await saveTVWatchList.execute(event.tv);
      watchListResult.fold(
        (failure) {
          emit(state.copyWith(watchlistMessage: failure.message));
        },
        (message) {
          emit(state.copyWith(watchlistMessage: message));
        },
      );
      add(LoadStatusWatchlist(event.tv.id));
    });

    on<RemoveFromWatchlist>((event, emit) async {
      final watchListResult = await removeTVWatchList.execute(event.tv);
      watchListResult.fold(
        (failure) {
          emit(state.copyWith(watchlistMessage: failure.message));
        },
        (message) {
          emit(state.copyWith(watchlistMessage: message));
        },
      );
      add(LoadStatusWatchlist(event.tv.id));
    });

    on<LoadStatusWatchlist>((event, emit) async {
      bool watchListResult = await getTVWatchListStatus.execute(event.id);
      emit(state.copyWith(isAddedToWatchlist: watchListResult, message: ''));
    });
  }
}
