import 'package:movies/movies.dart';

class TopRatedMoviesBloc extends Bloc<BlocMoviesEvent, BlocMoviesState> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMoviesBloc(this._getTopRatedMovies) : super(BlocMoviesEmpty()) {
    on<BlocGetMoviesEvent>((event, emit) async {
      emit(BlocMoviesLoading());
      final result = await _getTopRatedMovies.execute();

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
