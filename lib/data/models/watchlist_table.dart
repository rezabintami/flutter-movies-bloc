import 'package:ditonton/domain/entities/watchlist.dart';
import 'package:equatable/equatable.dart';

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

  Map<String, dynamic> toJson() => {
        'id': id,
        'is_movie': 1,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
      };

  Watchlist toEntity() => Watchlist.watchlist(
        id: id,
        isMovie: isMovie,
        overview: overview,
        posterPath: posterPath,
        title: title,
      );

  @override
  List<Object?> get props => [id, title, posterPath, overview];
}
