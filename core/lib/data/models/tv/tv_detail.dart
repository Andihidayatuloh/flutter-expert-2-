import 'package:core/data/models/genre_model.dart';
import 'package:core/domain/entities/tv/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TvDetailResponse extends Equatable {
  TvDetailResponse({
    required this.backdropPath,
    // required this.createdBy,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    // required this.lastEpisodeToAir,
    required this.name,
    // required this.nextEpisodeToAir,
    // required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    // required this.productionCompanies,
    // required this.productionCountries,
    required this.seasons,
    // required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  // List<CreatedBy> createdBy;
  final List<int> episodeRunTime;
  final DateTime firstAirDate;
  final List<GenreModel> genres;
  final String homepage;
  final int id;
  final bool inProduction;
  final List<String> languages;
  final DateTime lastAirDate;
  // LastEpisodeToAir lastEpisodeToAir;
  final String name;
  // dynamic nextEpisodeToAir;
  // List<Network> networks;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  // List<Network> productionCompanies;
  // List<ProductionCountry> productionCountries;
  final List<Season> seasons;
  // List<SpokenLanguage> spokenLanguages;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;

  factory TvDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvDetailResponse(
        backdropPath: json["backdrop_path"],
        episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x)),
        firstAirDate: DateTime.parse(json["first_air_date"]),
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        inProduction: json["in_production"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        lastAirDate: DateTime.parse(json["last_air_date"]),
        name: json["name"],
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        status: json["status"],
        tagline: json["tagline"],
        type: json["type"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        seasons:
            List<Season>.from(json["seasons"].map((x) => Season.fromJson(x))),
        voteAverage: json["vote_average"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        // "created_by": List<dynamic>.from(createdBy.map((x) => x.toJson())),
        "episode_run_time": List<dynamic>.from(episodeRunTime.map((x) => x)),
        "first_air_date":
            "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "in_production": inProduction,
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "last_air_date":
            "${lastAirDate.year.toString().padLeft(4, '0')}-${lastAirDate.month.toString().padLeft(2, '0')}-${lastAirDate.day.toString().padLeft(2, '0')}",
        // "last_episode_to_air": lastEpisodeToAir.toJson(),
        "name": name,
        // "next_episode_to_air": nextEpisodeToAir,
        // "networks": List<dynamic>.from(networks.map((x) => x.toJson())),
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        // "production_companies":
        //     List<dynamic>.from(productionCompanies.map((x) => x.toJson())),
        // "production_countries":
        //     List<dynamic>.from(productionCountries.map((x) => x.toJson())),
        "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
        // "spoken_languages":
        //     List<dynamic>.from(spokenLanguages.map((x) => x.toJson())),
        "status": status,
        "tagline": tagline,
        "type": type,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  TvDetail toEntity() {
    return TvDetail(
        backdropPath: backdropPath,
        episodeRunTime: episodeRunTime,
        firstAirDate: firstAirDate,
        genres: genres.map((genre) => genre.toEntity()).toList(),
        homepage: homepage,
        id: id,
        inProduction: inProduction,
        languages: languages,
        lastAirDate: lastAirDate,
        name: name,
        // nextEpisodeToAir: nextEpisodeToAir,
        numberOfEpisodes: numberOfEpisodes,
        numberOfSeasons: numberOfSeasons,
        originCountry: originCountry,
        originalLanguage: originalLanguage,
        originalName: originalName,
        overview: overview,
        popularity: popularity,
        posterPath: posterPath,
        seasons: seasons,
        status: status,
        tagline: tagline,
        type: type,
        voteAverage: voteAverage,
        voteCount: voteCount);
  }

  @override
  List<Object?> get props => [
        backdropPath,
        // List<CreatedBy> createdBy;
        episodeRunTime,
        firstAirDate,
        genres,
        homepage,
        id,
        inProduction,
        languages,
        lastAirDate,
        // LastEpisodeToAir lastEpisodeToAir;
        name,
        // nextEpisodeToAir,
        // List<Network> networks;
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        // List<Network> productionCompanies;
        // List<ProductionCountry> productionCountries;
        seasons,
        // List<SpokenLanguage> spokenLanguages;
        status,
        tagline,
        type,
        voteAverage,
        voteCount,
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