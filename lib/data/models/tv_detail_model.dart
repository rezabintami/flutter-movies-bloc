import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TVDetailResponse extends Equatable {
  TVDetailResponse({
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
      adult: this.adult,
      backdropPath: this.backdropPath,
      genres: this.genres.map((genre) => genre.toEntity()).toList(),
      homepage: this.homepage,
      id: this.id,
      lastEpisode: this.lastEpisode?.toEntity(),
      nextEpisode: this.nextEpisode?.toEntity(),
      inProduction: this.inProduction,
      name: this.name,
      originalName: this.originalName,
      overview: this.overview,
      posterPath: this.posterPath,
      season: this.season.map((season) => season.toEntity()).toList(),
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
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
