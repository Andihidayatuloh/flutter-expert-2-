import 'package:movies/movies.dart';

// Bloc
class WatchlistMoviesBloc
    extends Bloc<BlocWatchlistMoviesEvent, WatchlistMoviesState> {
  final GetWatchlistMovies _getWatchlistMovies;

  WatchlistMoviesBloc(this._getWatchlistMovies)
      : super(WatchlistMoviesEmpty()) {
    on<BlocWatchlistMoviesEvent>((event, emit) async {
      emit(WatchlistMoviesLoading());
      final result = await _getWatchlistMovies.execute();

      result.fold(
        (failure) {
          emit(WatchlistMoviesError(failure.message));
        },
        (data) {
          data.isNotEmpty
              ? emit(WatchlistMoviesLoaded(data))
              : emit(WatchlistMoviesEmpty());
        },
      );
    });
  }
}

// Bloc Event
abstract class BlocWatchlistMoviesEvent extends Equatable {
  const BlocWatchlistMoviesEvent();

  @override
  List<Object> get props => [];
}

class BlocGetWatchlistMovies extends BlocWatchlistMoviesEvent {}

// Bloc State
abstract class WatchlistMoviesState extends Equatable {
  const WatchlistMoviesState();

  @override
  List<Object> get props => [];
}

class WatchlistMoviesEmpty extends WatchlistMoviesState {}

class WatchlistMoviesLoading extends WatchlistMoviesState {}

class WatchlistMoviesError extends WatchlistMoviesState {
  final String message;

  const WatchlistMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistMoviesLoaded extends WatchlistMoviesState {
  final List<Movie> result;

  const WatchlistMoviesLoaded(this.result);

  @override
  List<Object> get props => [result];
}
