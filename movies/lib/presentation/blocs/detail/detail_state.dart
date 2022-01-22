part of 'detail_bloc.dart';

class DetailState extends Equatable {
  final MovieDetail movieDetail;
  final RequestState movieDetailState;
  final List<Movie> movieRecommendations;
  final RequestState movieRecommendationsState;
  final bool isAddedToWatchlist;
  final String message;
  final String watchlistMessage;
  DetailState(
      {required this.movieDetail,
      required this.movieDetailState,
      required this.movieRecommendations,
      required this.movieRecommendationsState,
      required this.isAddedToWatchlist,
      required this.message,
      required this.watchlistMessage});
  @override
  List<Object> get props => [
        movieDetail,
        movieDetailState,
        movieRecommendations,
        movieRecommendationsState,
        isAddedToWatchlist,
        message,
        watchlistMessage
      ];

  DetailState copyWith(
      {MovieDetail? movieDetail,
      RequestState? movieDetailState,
      List<Movie>? movieRecommendations,
      RequestState? movieRecommendationsState,
      bool? isAddedToWatchlist,
      String? message,
      String? watchlistMessage}) {
    return DetailState(
        movieDetail: movieDetail ?? this.movieDetail,
        movieDetailState: movieDetailState ?? this.movieDetailState,
        movieRecommendations: movieRecommendations ?? this.movieRecommendations,
        movieRecommendationsState:
            movieRecommendationsState ?? this.movieRecommendationsState,
        isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
        message: message ?? this.message,
        watchlistMessage: watchlistMessage ?? this.watchlistMessage);
  }

  factory DetailState.initial() => DetailState(
      movieDetail: MovieDetail(
        adult: false,
        backdropPath: 'backdropPath',
        genres: [Genre(id: 1, name: 'Action')],
        id: 1,
        originalTitle: 'originalTitle',
        overview: 'overview',
        posterPath: 'posterPath',
        releaseDate: 'releaseDate',
        runtime: 120,
        title: 'title',
        voteAverage: 1.0,
        voteCount: 1,
      ),
      movieDetailState: RequestState.Empty,
      movieRecommendations: [],
      movieRecommendationsState: RequestState.Empty,
      isAddedToWatchlist: false,
      message: '',
      watchlistMessage: '');
}
