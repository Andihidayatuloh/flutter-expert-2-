import 'package:movies/movies.dart';

abstract class BlocMoviesEvent extends Equatable {
  const BlocMoviesEvent();

  @override
  List<Object> get props => [];
}

class BlocGetMoviesEvent extends BlocMoviesEvent {}

abstract class BlocMoviesState extends Equatable {
  const BlocMoviesState();

  @override
  List<Object> get props => [];
}

class BlocMoviesEmpty extends BlocMoviesState {}

class BlocMoviesLoading extends BlocMoviesState {}

class BlocMoviesError extends BlocMoviesState {
  final String message;

  const BlocMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class BlocMoviesLoaded extends BlocMoviesState {
  final List<Movie> result;

  const BlocMoviesLoaded(this.result);

  @override
  List<Object> get props => [result];
}

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
