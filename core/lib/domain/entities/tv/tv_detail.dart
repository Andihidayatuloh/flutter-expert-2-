import 'package:core/core.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class TvDetail extends Equatable {
  const TvDetail({
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
  final List<Genre> genres;
  final int id;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String overview;
  final String posterPath;
  final List<Season> seasons;
  final double voteAverage;

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
