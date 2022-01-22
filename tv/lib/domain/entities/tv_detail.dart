import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/episode.dart';
import 'package:tv/domain/entities/genre.dart';
import 'package:tv/domain/entities/season.dart';

class TVDetail extends Equatable {
  TVDetail({
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.lastEpisode,
    required this.nextEpisode,
    required this.inProduction,
    required this.name,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.season,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String? backdropPath;
  final List<Genre> genres;
  final String homepage;
  final int id;
  final Episode? lastEpisode;
  final Episode? nextEpisode;
  final bool inProduction;
  final String name;
  final String originalName;
  final String overview;
  final String posterPath;
  final List<Season> season;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genres,
        homepage,
        id,
        lastEpisode,
        nextEpisode,
        inProduction,
        name,
        originalName,
        overview,
        posterPath,
        season,
        voteAverage,
        voteCount,
      ];
}
