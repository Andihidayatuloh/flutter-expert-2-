import 'package:movies/movies.dart';

class BlocPopularMoviesBloc extends Bloc<BlocMoviesEvent, BlocMoviesState> {
  final GetPopularMovies _getPopularMovies;

  BlocPopularMoviesBloc(this._getPopularMovies) : super(BlocMoviesEmpty()) {
    on<BlocGetMoviesEvent>((event, emit) async {
      emit(BlocMoviesLoading());
      final result = await _getPopularMovies.execute();

      result.fold(
        (failure) {
          emit(BlocMoviesError(failure.message));
        },
        (data) {
          emit(BlocMoviesLoaded(data));
        },
      );
    });
  }
}
