import 'package:tv/tv.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchTvDetail extends TvDetailEvent {
  final int id;

  const FetchTvDetail(this.id);

  @override
  List<Object> get props => [id];
}

class AddWatchlist extends TvDetailEvent {
  final TvDetail tvDetail;

  const AddWatchlist(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class RemoveFromWatchlist extends TvDetailEvent {
  final TvDetail tvDetail;

  const RemoveFromWatchlist(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class LoadWatchlistStatus extends TvDetailEvent {
  final int id;

  const LoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
