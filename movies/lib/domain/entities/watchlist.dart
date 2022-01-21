import 'package:equatable/equatable.dart';

class Watchlist extends Equatable {
  Watchlist({
    required this.id,
    required this.isMovie,
    required this.overview,
    required this.posterPath,
    required this.title,
  });

  Watchlist.watchlist({
    required this.id,
    required this.isMovie,
    required this.overview,
    required this.posterPath,
    required this.title,
  });

  int id;
  int? isMovie;
  String? overview;
  String? posterPath;
  String? title;

  @override
  List<Object?> get props => [
        id,
        overview,
        posterPath,
        title,
      ];
}
