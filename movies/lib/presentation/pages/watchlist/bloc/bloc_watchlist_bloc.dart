import 'package:movies/movies.dart';




class WatchlistMoviesBloc extends Bloc<BlocWatchlistEvent, WatchlistState> {
  final GetWatchlistMovies _getWatchlistMovies;

  WatchlistMoviesBloc(this._getWatchlistMovies) : super(WatchlistEmpty()) {
    on<BlocWatchlistEvent>((event, emit) async {
      emit(WatchlistLoading());
      final result = await _getWatchlistMovies.execute();

      result.fold(
        (failure) {
          emit(WatchlistError(failure.message));
        },
        (data) {
          emit(WatchlistLoaded<Movie>(data));
        },
      );
    });
  }
}

