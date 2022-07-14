import 'package:core/data/models/genre_model.dart';
import 'package:core/domain/entities/tv/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TvDetailResponse extends Equatable {
  const TvDetailResponse({
    required this.episodeRunTime,
    required this.genres,
    required this.id,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.overview,
    required this.posterPath,
    required this.seasons,
    required this.voteAverage,
  });

  final List<int> episodeRunTime;
  final List<GenreModel> genres;
  final int id;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String overview;
  final String posterPath;
  final List<Season> seasons;
  final double voteAverage;

  factory TvDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvDetailResponse(
        episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x)),
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        id: json["id"],
        name: json["name"],
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasons:
            List<Season>.from(json["seasons"].map((x) => Season.fromJson(x))),
        voteAverage: json["vote_average"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "episode_run_time": List<dynamic>.from(episodeRunTime.map((x) => x)),
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "id": id,
        "name": name,
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "overview": overview,
        "poster_path": posterPath,
        "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
        "vote_average": voteAverage,
      };

  TvDetail toEntity() {
    return TvDetail(
      episodeRunTime: episodeRunTime,
      genres: genres.map((genre) => genre.toEntity()).toList(),
      id: id,
      name: name,
      numberOfEpisodes: numberOfEpisodes,
      numberOfSeasons: numberOfSeasons,
      overview: overview,
      posterPath: posterPath,
      seasons: seasons,
      voteAverage: voteAverage,
    );
  }

  @override
  List<Object?> get props => [
        episodeRunTime,
        genres,
        id,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        overview,
        posterPath,
        seasons,
        voteAverage,
      ];
}

class Season extends Equatable {
  const Season({
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.seasonNumber,
  });

  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final int seasonNumber;

  factory Season.fromJson(Map<String, dynamic> json) => Season(
        episodeCount: json["episode_count"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        seasonNumber: json["season_number"],
      );

  Map<String, dynamic> toJson() => {
        "episode_count": episodeCount,
        "id": id,
        "name": name,
        "overview": overview,
        "season_number": seasonNumber,
      };

  @override
  List<Object?> get props => [
        episodeCount,
        id,
        name,
        overview,
        seasonNumber,
      ];
}
