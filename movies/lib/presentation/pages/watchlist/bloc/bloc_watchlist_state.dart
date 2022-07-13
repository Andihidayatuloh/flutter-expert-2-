import 'package:movies/movies.dart';

abstract class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object> get props => [];
}

class WatchlistEmpty extends WatchlistState {}

class WatchlistLoading extends WatchlistState {}

class WatchlistError extends WatchlistState {
  final String message;

  const WatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistLoaded<T> extends WatchlistState {
  final List<T> result;

  const WatchlistLoaded(this.result);

  @override
  List<Object> get props => [result];
}
