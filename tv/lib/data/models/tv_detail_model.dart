import 'package:equatable/equatable.dart';
import 'package:tv/data/models/episode_model.dart';
import 'package:tv/data/models/genre_model.dart';
import 'package:tv/data/models/season_model.dart';
import 'package:tv/domain/entities/tv_detail.dart';

class TVDetailResponse extends Equatable {
  const TVDetailResponse({
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
  final List<GenreModel> genres;
  final String homepage;
  final int id;
  final EpisodeModel? lastEpisode;
  final EpisodeModel? nextEpisode;
  final bool inProduction;
  final String name;
  final String originalName;
  final String overview;
  final String posterPath;
  final List<SeasonModel> season;
  final double voteAverage;
  final int voteCount;

  factory TVDetailResponse.fromJson(Map<String, dynamic> json) =>
      TVDetailResponse(
        adult: json['adult'],
        backdropPath: json['backdrop_path'],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        homepage: json['homepage'],
        id: json['id'],
        lastEpisode: json['last_episode_to_air'] == null
            ? null
            : EpisodeModel.fromJson(json['last_episode_to_air']),
        nextEpisode: json['next_episode_to_air'] == null
            ? null
            : EpisodeModel.fromJson(json['next_episode_to_air']),
        inProduction: json['in_production'],
        name: json['name'],
        originalName: json['original_name'],
        overview: json['overview'],
        posterPath: json['poster_path'],
        season: List<SeasonModel>.from(
            json["seasons"].map((x) => SeasonModel.fromJson(x))),
        voteAverage: json['vote_average'].toDouble(),
        voteCount: json['vote_count'],
      );

  Map<String, dynamic> toJson() => {
        'adult': adult,
        'backdrop_path': backdropPath,
        'genres': List<dynamic>.from(genres.map((x) => x.toJson())),
        'homepage': homepage,
        'id': id,
        'last_episode_to_air': lastEpisode?.toJson(),
        'next_episode_to_air': nextEpisode?.toJson(),
        'in_production': inProduction,
        'name': name,
        'original_name': originalName,
        'overview': overview,
        'poster_path': posterPath,
        'seasons': List<dynamic>.from(season.map((x) => x.toJson())),
        'vote_average': voteAverage,
        'vote_count': voteCount,
      };

  TVDetail toEntity() {
    return TVDetail(
      adult: adult,
      backdropPath: backdropPath,
      genres: genres.map((genre) => genre.toEntity()).toList(),
      homepage: homepage,
      id: id,
      lastEpisode: lastEpisode?.toEntity(),
      nextEpisode: nextEpisode?.toEntity(),
      inProduction: inProduction,
      name: name,
      originalName: originalName,
      overview: overview,
      posterPath: posterPath,
      season: season.map((season) => season.toEntity()).toList(),
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

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
