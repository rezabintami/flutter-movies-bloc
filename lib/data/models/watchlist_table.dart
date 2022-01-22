import 'package:ditonton/domain/entities/watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:tv/domain/entities/tv_detail.dart';

class WatchListTable extends Equatable {
  final int id;
  final int? isMovie;
  final String? title;
  final String? posterPath;
  final String? overview;

  WatchListTable({
    required this.id,
    required this.isMovie,
    required this.title,
    required this.posterPath,
    required this.overview,
  });

  factory WatchListTable.fromMap(Map<String, dynamic> map) => WatchListTable(
        id: map['id'],
        isMovie: map['is_movie'],
        title: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  factory WatchListTable.fromMovieEntity(MovieDetail movie) => WatchListTable(
        id: movie.id,
        isMovie: 1,
        title: movie.title,
        posterPath: movie.posterPath,
        overview: movie.overview,
      );

  factory WatchListTable.fromTVEntity(TVDetail tv) => WatchListTable(
        id: tv.id,
        isMovie: 0,
        title: tv.name,
        posterPath: tv.posterPath,
        overview: tv.overview,
      );

  Watchlist toEntity() => Watchlist.watchlist(
        id: id,
        isMovie: isMovie,
        overview: overview,
        posterPath: posterPath,
        title: title,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'is_movie': isMovie,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
      };

  @override
  List<Object?> get props => [id, title, posterPath, overview];
}
