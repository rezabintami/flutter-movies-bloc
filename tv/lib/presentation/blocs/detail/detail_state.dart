part of 'detail_bloc.dart';

class DetailState extends Equatable {
  final TVDetail tvDetail;
  final RequestState tvDetailState;
  final List<TV> tvRecommendations;
  final RequestState tvRecommendationsState;
  final bool isAddedToWatchlist;
  final String message;
  final String watchlistMessage;
  DetailState(
      {required this.tvDetail,
      required this.tvDetailState,
      required this.tvRecommendations,
      required this.tvRecommendationsState,
      required this.isAddedToWatchlist,
      required this.message,
      required this.watchlistMessage});
  @override
  List<Object> get props => [
        tvDetail,
        tvDetailState,
        tvRecommendations,
        tvRecommendationsState,
        isAddedToWatchlist,
        message,
        watchlistMessage
      ];

  DetailState copyWith({
    TVDetail? tvDetail,
    RequestState? tvDetailState,
    List<TV>? tvRecommendations,
    RequestState? tvRecommendationsState,
    bool? isAddedToWatchlist,
    String? message,
    String? watchlistMessage,
  }) {
    return DetailState(
      tvDetail: tvDetail ?? this.tvDetail,
      tvDetailState: tvDetailState ?? this.tvDetailState,
      tvRecommendations: tvRecommendations ?? this.tvRecommendations,
      tvRecommendationsState:
          tvRecommendationsState ?? this.tvRecommendationsState,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
    );
  }

  factory DetailState.initial() => DetailState(
      tvDetail: TVDetail(
          adult: false,
          backdropPath: 'backdropPath',
          genres: [Genre(id: 1, name: 'Action')],
          id: 1,
          originalName: 'originalTitle',
          overview: 'overview',
          posterPath: 'posterPath',
          name: 'title',
          voteAverage: 1,
          voteCount: 1,
          homepage: 'homepage',
          inProduction: true,
          lastEpisode: null,
          nextEpisode: null,
          season: []),
      tvDetailState: RequestState.Empty,
      tvRecommendations: [],
      tvRecommendationsState: RequestState.Empty,
      isAddedToWatchlist: false,
      message: '',
      watchlistMessage: '');
}
