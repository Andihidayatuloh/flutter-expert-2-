import 'package:movies/movies.dart';

abstract class BlocPopularMoviesEvent extends Equatable {
  const BlocPopularMoviesEvent();

  @override
  List<Object> get props => [];
}

class BlocGetPopularMoviesEvent extends BlocPopularMoviesEvent {}

abstract class BlocPopularMoviesState extends Equatable {
  const BlocPopularMoviesState();

  @override
  List<Object> get props => [];
}

class BlocPopularMoviesEmpty extends BlocPopularMoviesState {}

class BlocPopularMoviesLoading extends BlocPopularMoviesState {}

class BlocPopularMoviesError extends BlocPopularMoviesState {
  final String message;

  const BlocPopularMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class BlocPopularMoviesLoaded extends BlocPopularMoviesState {
  final List<Movie> result;

  const BlocPopularMoviesLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class BlocPopularMoviesBloc
    extends Bloc<BlocPopularMoviesEvent, BlocPopularMoviesState> {
  final GetPopularMovies _getPopularMovies;

  BlocPopularMoviesBloc(this._getPopularMovies)
      : super(BlocPopularMoviesEmpty()) {
    on<BlocPopularMoviesEvent>((event, emit) async {
      emit(BlocPopularMoviesLoading());
      final result = await _getPopularMovies.execute();

      result.fold(
        (failure) {
          emit(BlocPopularMoviesError(failure.message));
        },
        (data) {
          emit(BlocPopularMoviesLoaded(data));
        },
      );
    });
  }
}
