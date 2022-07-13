import 'package:movies/movies.dart';



class BlocMoviesListBloc extends Bloc<BlocMoviesEvent, BlocMoviesState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  BlocMoviesListBloc(this._getNowPlayingMovies) : super(BlocMoviesEmpty()) {
    on<BlocGetMoviesEvent>((event, emit) async {
      emit(BlocMoviesLoading());
      final result = await _getNowPlayingMovies.execute();

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
