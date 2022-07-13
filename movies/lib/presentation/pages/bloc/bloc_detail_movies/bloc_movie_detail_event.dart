import 'package:movies/movies.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieDetail extends MovieDetailEvent {
  final int id;

  const FetchMovieDetail(this.id);

  @override
  List<Object> get props => [id];
}

class AddWatchlist extends MovieDetailEvent {
  final MovieDetail movieDetail;

  const AddWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class RemoveFromWatchlist extends MovieDetailEvent {
  final MovieDetail movieDetail;

  const RemoveFromWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class LoadWatchlistStatus extends MovieDetailEvent {
  final int id;

  const LoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
