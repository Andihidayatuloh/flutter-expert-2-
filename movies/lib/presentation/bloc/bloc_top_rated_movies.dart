import 'package:movies/movies.dart';

abstract class BlocTopRatedMoviesEvent extends Equatable {
  const BlocTopRatedMoviesEvent();

  @override
  List<Object> get props => [];
}

class BlocGetTopRatedMoviesEvent extends BlocTopRatedMoviesEvent {}

abstract class BlocTopRatedMoviesState extends Equatable {
  const BlocTopRatedMoviesState();

  @override
  List<Object> get props => [];
}

class BlocTopRatedMoviesEmpty extends BlocTopRatedMoviesState {}

class BlocTopRatedMoviesLoading extends BlocTopRatedMoviesState {}

class BlocTopRatedMoviesError extends BlocTopRatedMoviesState {
  final String message;

  const BlocTopRatedMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class BlocTopRatedMoviesLoaded extends BlocTopRatedMoviesState {
  final List<Movie> result;

  const BlocTopRatedMoviesLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class TopRatedMoviesBloc
    extends Bloc<BlocTopRatedMoviesEvent, BlocTopRatedMoviesState> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMoviesBloc(this._getTopRatedMovies)
      : super(BlocTopRatedMoviesEmpty()) {
    on<BlocTopRatedMoviesEvent>((event, emit) async {
      emit(BlocTopRatedMoviesLoading());
      final result = await _getTopRatedMovies.execute();

      result.fold(
        (failure) {
          emit(BlocTopRatedMoviesError(failure.message));
        },
        (data) {
          emit(BlocTopRatedMoviesLoaded(data));
        },
      );
    });
  }
}
