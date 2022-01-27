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

  final int id;
  final int? isMovie;
  final String? overview;
  final String? posterPath;
  final String? title;

  @override
  List<Object?> get props => [
        id,
        overview,
        posterPath,
        title,
      ];
}
